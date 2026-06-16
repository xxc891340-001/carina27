# HelloTenant Refresh Strategy

## Design principle

Not every data refresh should produce a new AreaSnapshot. Not every new AreaSnapshot should trigger Recommendation regeneration. The goal is not to keep every metric perfectly up to date — it is to keep the interpretation accurate and useful for renter decision-making.

Two gates separate raw data from regenerated content:

```
Data source refresh
        │
        ▼
Change detection (is this delta meaningful for renters?)
        │
        ├── No  → discard, no new snapshot
        │
        └── Yes → new AreaSnapshot
                        │
                        ▼
                Regeneration threshold check (does this justify rewriting the page?)
                        │
                        ├── No  → snapshot recorded, no regeneration
                        │
                        └── Yes → queue GenerationJob
```

Thresholds are intentionally conservative. A small fluctuation in crime rates does not justify rewriting a page that a human or reviewer has already approved. A new supermarket opening changes what a renter should actually do.

---

## Per-module refresh strategy

### Crime

| Property | Value |
|---|---|
| **Source** | police.uk Street Level Crime API |
| **Data lag** | ~2 months (July data arrives in September) |
| **Refresh cadence** | Every 6 weeks |
| **Meaningful change** | Top crime category changes; rate shifts ≥15% vs previous snapshot; trend direction reverses (improving → worsening or vice versa) |
| **Not meaningful** | Rate fluctuation <10% within same category profile; seasonal variance in ASB near transport hubs |
| **Trigger regeneration?** | Yes, on meaningful change |
| **Rationale** | Crime profile shifts slowly. A 3% month-on-month change is noise. A category change or a 15%+ shift changes what a renter should actually do — check different security features, reconsider insurance, or understand the area differently. |

---

### Rent

| Property | Value |
|---|---|
| **Source** | ONS Private Rental Index; Rightmove/Zoopla aggregated asking rents |
| **Refresh cadence** | Monthly |
| **Meaningful change** | Median rent moves ≥8% in any bedroom category; area crosses from "similar to borough median" to "above" or "below"; trend direction changes (stable → rising fast, or vice versa) |
| **Not meaningful** | <5% change (within seasonal variation, e.g. summer rental market uplift) |
| **Trigger regeneration?** | Yes, on meaningful change |
| **Rationale** | The Recommendation includes comparison language ("slightly above the borough average") that becomes factually wrong when rents shift significantly. Below 8% the comparison language still holds and regeneration adds no value. |

---

### Transport

| Property | Value |
|---|---|
| **Source** | TfL Unified API; National Rail timetable data |
| **Refresh cadence** | Monthly check; event-driven for infrastructure changes |
| **Meaningful change** | New station opens within walking distance; journey time to destination changes ≥10 minutes; night transport availability changes; zone change that shifts annual travelcard cost >£200/yr |
| **Not meaningful** | Weekend engineering closures; timetable changes ≤5 minutes; bus route renumbering with equivalent coverage |
| **Trigger regeneration?** | Yes for infrastructure changes; no for timetable noise |
| **Rationale** | Transport content is highly stable. Most change events are minor. A new station is a significant event that changes journey times, annual costs, and the commute mode recommendation. A 3-minute timetable adjustment does not. |

---

### Schools

| Property | Value |
|---|---|
| **Source** | Ofsted inspection database; DfE school performance tables |
| **Refresh cadence** | Quarterly check (Ofsted inspections are irregular — years may pass between inspections for the same school) |
| **Meaningful change** | Any school within 1km changes Ofsted rating; school closes or opens |
| **Not meaningful** | Marginal performance metric changes without rating change; waiting list fluctuations |
| **Trigger regeneration?** | Yes, on rating change or school opening/closing |
| **Rationale** | Schools data is highly stable. The Recommendation references Ofsted ratings directly, so a rating change (Good → Requires Improvement) makes the content factually wrong. This is a low-frequency, high-importance trigger. |

---

### GP and Healthcare

| Property | Value |
|---|---|
| **Source** | NHS API (accepting patients flag); CQC ratings |
| **Refresh cadence** | Monthly |
| **Meaningful change** | Area loses all GP practices accepting new patients; new GP practice opens; nearest A&E changes type (full A&E → minor injuries unit, or vice versa) |
| **Not meaningful** | Individual practice temporarily pausing registrations; minor opening hours changes; single CQC rating change without closure |
| **Trigger regeneration?** | Yes, on structural capacity changes |
| **Rationale** | The next_actions for this module are durable — register with a GP, find your nearest A&E. Content only needs to change when the supply situation changes materially. Individual practice fluctuations are too granular to justify page regeneration. |

---

### Noise

| Property | Value |
|---|---|
| **Source** | Council licensing database; local authority planning portal; NATS/CAA flight path data |
| **Refresh cadence** | Monthly |
| **Meaningful change** | Late-night venue (licence permits closing after midnight) opens within 200m; major road infrastructure change confirmed or completed; flight path change affecting the area |
| **Not meaningful** | Individual small venue (café, restaurant closing by 22:00) opens or closes; temporary events; short-term construction without multi-year planning permission |
| **Trigger regeneration?** | Yes, on meaningful change — particularly new late-night licensed venues |
| **Rationale** | Noise content is stable unless the character of the area changes. A new late-night venue 100m from a residential street materially changes what a renter should check when viewing. A café opening does not. |

---

### Amenities

| Property | Value |
|---|---|
| **Source** | Ordnance Survey Points of Interest; council open data; Google Places API for coverage gaps |
| **Refresh cadence** | Quarterly |
| **Meaningful change** | Large supermarket (>500m² floor area) opens or closes within 15-minute walk; significant new green space created or closed; major co-working or community facility opens |
| **Not meaningful** | Individual café, restaurant, or small shop opens or closes; gym rebrands; minor amenity changes |
| **Trigger regeneration?** | Yes, for supermarket or green space changes; no for small amenity churn |
| **Rationale** | The Recommendation specifically calls out large supermarket proximity as a practical daily need. Losing or gaining one changes the content materially. Individual café churn is irrelevant to renter decision-making. |

---

## Aggregation: when do module changes trigger Recommendation regeneration?

A new AreaSnapshot is created when one or more modules report a meaningful change. A Recommendation regeneration is queued when:

- **Any single module** exceeds its meaningful change threshold — regenerate immediately
- **Sub-threshold drift across multiple modules** — flag for a quarterly editorial pass rather than automatic regeneration. Two or three modules with minor changes that together shift the overall picture can be reviewed together.

---

## Estimated regeneration frequency

Based on typical London area data patterns:

| Module | Expected meaningful changes per area per year |
|---|---|
| Crime | 1–2 |
| Rent | 1–3 |
| Transport | <1 |
| Schools | <0.5 |
| GP / Healthcare | <0.5 |
| Noise | <1 |
| Amenities | <1 |

For a library of 200 areas and 2 locales, this suggests roughly **400–800 Recommendation regenerations per year** — well under two per area per week on average, clustered around rent and crime refresh cycles. This is considerably cheaper than regenerating on every monthly data refresh across all modules.

The dominant ongoing cost driver is InterpretationRule evolution (Editorial Refresh), not Data Refresh. When a rule is improved, it regenerates all AI-generated Recommendations for that locale in priority order. This is a controlled, deliberate operation rather than a continuous background cost.

---

## Relationship to InterpretationRule evolution

Data Refresh is the mechanism for keeping content factually current. Editorial Refresh — activating an improved InterpretationRule — is the mechanism for keeping content qualitatively better. These operate independently.

The refresh thresholds above govern Data Refresh only. Editorial Refresh is triggered explicitly by activating a new rule version, not by a data change. See the entity model for the full distinction between the two regeneration paths.
