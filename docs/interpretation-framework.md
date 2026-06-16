# HelloTenant Interpretation Framework

## Design principle

Every module follows the same four-step flow:

> **What the data shows → What this means for you → What to look out for → What to do next**

Language rule applied across all modules: write as if explaining to someone renting in the UK for the first time, in English that may be their second language. Avoid technical, policy, or analyst terminology. Use short sentences and everyday language. Prefer examples and comparisons over abstract concepts.

The distinction between the final two steps is intentional:

- **What to look out for** — awareness. Things to notice, observe, or investigate.
- **What to do next** — action. Concrete, time-bound tasks the renter should complete (during viewing / before signing / immediately after moving in).

---

## Module 1 — Crime

**Input data**
- Crime category breakdown (police.uk): violence, theft, burglary, antisocial behaviour, vehicle crime, drug offences, bicycle theft
- Rate per 1,000 residents, year-on-year trend
- Borough and London average for comparison

**What the data shows**
- The three most common types of reported incidents in this area
- Whether incidents mainly involve people passing through (visitors, commuters) or residents at home
- Whether the situation has been getting better or worse over the past year

**What this means for renters**
- Busy areas near train stations, markets, or shopping streets often show high crime numbers, but most of these incidents happen to people visiting the area, not people who live there. A high number on its own does not mean the area is unsafe to live in.
- The types of crime that matter most for residents are: break-ins at home, car or bike theft, and antisocial behaviour in residential streets. These are worth looking at separately from overall totals.
- If the area is near a university or busy transport hub, phone theft and bike theft are common and predictable — not a sign of a generally unsafe neighbourhood.

**What to look out for**
- Whether the front door and communal areas of the building have secure entry
- Whether there is safe, locked storage for a bicycle
- Whether the street is well-lit at night
- Whether the area feels busy or quiet in the evening — visit after dark before committing

**What to do next**
- When viewing a property: check that the front door has a multipoint lock, not just a single latch
- Ask the letting agent or landlord whether the building has had any break-ins in the past year
- Check whether contents insurance is included or whether you need to arrange it — in some areas, insurers charge higher premiums
- If you have a bicycle, ask specifically about secure storage before signing

**Suggested output structure**
```json
{
  "top_incident_types": ["bicycle theft", "theft from person", "minor assault"],
  "incident_profile": "mostly_visitors | mostly_residents | mixed",
  "trend": "improving | stable | worsening",
  "plain_summary": "...",
  "what_this_means": "...",
  "what_to_look_for": ["...", "..."],
  "next_actions": ["...", "..."],
  "trade_off": {
    "acceptable_for": ["..."],
    "consider_carefully_if": ["..."]
  },
  "data_completeness": "complete | partial | limited"
}
```

---

## Module 2 — Rent

**Input data**
- Median monthly rent by bedroom count (1-bed, 2-bed, 3-bed)
- Year-on-year trend %
- vs. borough median, vs. similar areas nearby
- Bills-included prevalence in the local market

**What the data shows**
- What a typical monthly rent looks like in this area for different flat sizes
- Whether rents here are higher or lower than similar areas nearby
- Whether rents have been going up quickly or staying roughly the same

**What this means for renters**
- Paying more rent in a well-connected area is not always worse value than paying less in an area that requires an expensive daily commute. If this area saves you £100–150 per month on travel, a slightly higher rent may still work out cheaper overall.
- If rents in this area have been rising quickly, locking in a longer fixed-term tenancy now may protect you from a bigger increase at renewal.
- Some nearby areas offer similar commute times at lower rent — it is worth comparing two or three before deciding.

**What to look out for**
- Whether the advertised rent includes bills — student areas in particular often bundle bills, which changes the real comparison
- Whether the landlord is asking for more than one month's deposit upfront (the legal cap in England is five weeks' rent)
- Whether the flat is offered furnished or unfurnished — unfurnished at lower rent can cost more once you buy furniture

**What to do next**
- Before agreeing a rent, look at two or three similar flats in nearby areas with similar commute times — rents can vary significantly within a short distance
- If rents here are rising, ask the landlord whether they would offer an 18 or 24-month tenancy at the current price
- Use a travel cost calculator to compare total monthly outgoings (rent plus travel) rather than rent alone

**Suggested output structure**
```json
{
  "median_pcm": { "1bed": 0, "2bed": 0, "3bed": 0 },
  "trend_yoy_pct": 0,
  "vs_nearby_areas": "higher | similar | lower",
  "plain_summary": "...",
  "what_this_means": "...",
  "what_to_look_for": ["...", "..."],
  "next_actions": ["...", "..."],
  "comparable_areas": ["...", "..."],
  "data_completeness": "complete | partial | limited"
}
```

---

## Module 3 — Transport

**Input data**
- TfL zone(s), lines accessible, walk time to nearest station
- Bus routes and frequency
- Cycling infrastructure (lanes, hire bikes within 300m)
- Journey time to destination, peak and off-peak
- Night transport availability

**What the data shows**
- The most practical way to travel from this area to the destination
- How long the journey realistically takes, including the walk to the station and any waiting time
- Whether you can travel late at night if you need to

**What this means for renters**
- The journey time shown on maps is usually the best-case scenario. In practice, you also need to walk to the station, wait for the train or bus, and sometimes change lines. We have included all of this in the estimate.
- Buses are more flexible than the tube — you can catch one closer to home — but they take longer and can be delayed by traffic, especially in the morning.
- If you are in Fare Zone 2 or 3, a monthly travel card costs significantly more than Zone 1. Over a year, this can add up to several hundred pounds. It is worth factoring this into your overall budget.
- If the destination is less than 4km away and there are safe cycling routes, cycling can be faster than public transport and free after the cost of a bike.

**What to look out for**
- Whether the bus or tube route has a history of delays
- Whether there is night transport available if you work late or go out in the evenings
- Whether the nearest station is on one line only — if so, disruptions on that line may leave you without an easy alternative

**What to do next**
- Try the journey yourself at the time you would normally travel — not on a weekend or at midday, when services are quieter
- Check the annual travelcard price for your zones before budgeting — it is listed on the TfL website
- If you cycle or are thinking about it, walk or cycle the route once to check whether it feels safe and direct

**Suggested output structure**
```json
{
  "zone": "2",
  "recommended_mode": "tube | bus | overground | cycling | walking",
  "journey_summary": {
    "realistic_peak_minutes": 0,
    "includes": "walk to station + wait + ride",
    "plain_description": "..."
  },
  "annual_travel_cost_estimate_gbp": 0,
  "cycling_option": "practical | possible but longer | not recommended",
  "night_transport": "available all night | available until midnight | limited after midnight",
  "plain_summary": "...",
  "what_this_means": "...",
  "what_to_look_for": ["...", "..."],
  "next_actions": ["...", "..."],
  "data_completeness": "complete | partial | limited"
}
```

---

## Module 4 — Schools

**Input data**
- Ofsted-rated primary schools within 1km (count by rating: Outstanding, Good, Requires Improvement)
- Secondary schools within 2km and ratings
- Faith school prevalence
- SEN provision availability

**What the data shows**
- How many schools are nearby and what their most recent inspection rating is
- Whether there are options for children with additional needs
- Whether any nearby schools are faith schools with specific admission requirements

**What this means for renters**
- Having a good school nearby does not automatically mean your child will get a place there. Schools in popular areas often fill up with children who live even closer. Admission decisions are made based on where you live at the time you apply, not where you were living when you signed your tenancy.
- Inspection ratings can change. A school that was rated Outstanding a few years ago may have had new leadership since then, and the rating may not reflect what the school is like today.
- Faith schools often have additional admission criteria — for example, regular attendance at a place of worship, or a letter from a religious leader. These apply regardless of how close to the school you live.

**What to look out for**
- Whether the schools you are interested in have admitted children from this specific street in recent years — schools publish this information in their admission statistics
- Whether the school has a waiting list and how long it typically is
- What the SEN support offer is, if this is relevant for your family

**What to do next**
- Before signing a tenancy, call the school office directly and ask whether your postcode falls within their typical admission area — do not rely on a map alone
- Check the borough council's admissions page — it lists the furthest distance from which each school admitted children in the most recent school year
- If you are moving during term time, contact the council's school admissions team — they handle mid-year transfers

**Suggested output structure**
```json
{
  "primary_schools_nearby": { "outstanding": 0, "good": 0, "other": 0 },
  "secondary_schools_nearby": { "outstanding": 0, "good": 0, "other": 0 },
  "faith_schools_present": true,
  "sen_provision_note": "...",
  "plain_summary": "...",
  "what_this_means": "...",
  "what_to_look_for": ["...", "..."],
  "next_actions": ["...", "..."],
  "relevance_note": "Most relevant for renters with children of school age.",
  "data_completeness": "complete | partial | limited"
}
```

---

## Module 5 — GP and Healthcare

**Input data**
- GP practices within 1km, accepting new patients flag (NHS API where available)
- Walk time to nearest A&E
- Walk-in and urgent treatment centres within 2km
- NHS dental practices accepting new patients within 1km

**What the data shows**
- How many GP surgeries are nearby and whether they are currently taking new patients
- Where the nearest hospital A&E is and how long it takes to get there
- Whether there are any urgent care or walk-in clinics nearby for non-emergency situations

**What this means for renters**
- Finding a GP when you move to a new area is one of the first things you should do — not the first time you feel unwell. In some areas of London, GP surgeries have long waiting lists for new registrations, and you may have to try several before one accepts you.
- If you need to see a doctor urgently but it is not a life-threatening emergency, a walk-in centre or urgent treatment centre is usually faster than going to A&E. It also helps keep A&E available for serious emergencies.
- NHS dental care in London can be hard to find. Many practices that say they are NHS-registered are not currently accepting new patients. It is worth checking before you move rather than waiting until you have a dental problem.

**What to look out for**
- Whether the GP practices nearby are actually taking new registrations — the NHS website listing is not always up to date
- Whether the nearest A&E is a full emergency department or a minor injuries unit (minor injuries units cannot treat serious emergencies)
- Whether there is a pharmacy nearby that is open late or on Sundays

**What to do next**
- On your first or second day in the new property, register with a GP — bring proof of your new address
- If the nearest practices are not accepting patients, call NHS 111 and they can help you find one that is
- Find your nearest urgent treatment centre now and save the address — it is useful to know before you need it
- For dental care, search NHS.uk for dentists accepting NHS patients in your postcode — call ahead to confirm before visiting

**Suggested output structure**
```json
{
  "gp_practices_within_1km": 0,
  "accepting_patients": "yes | unclear — check directly | limited availability",
  "nearest_ae": { "name": "...", "walk_minutes": 0, "type": "full_ae | minor_injuries_unit" },
  "walk_in_centre": { "name": "...", "walk_minutes": 0 },
  "nhs_dental_note": "...",
  "plain_summary": "...",
  "what_this_means": "...",
  "what_to_look_for": ["...", "..."],
  "next_actions": ["...", "..."],
  "data_completeness": "complete | partial | limited"
}
```

---

## Module 6 — Noise

**Input data**
- Proximity to major roads (metres)
- Rail line proximity and type (underground surface, overground, mainline)
- Flight path position (CAA/NATS data)
- Licensed late-night venues within 200m (council licensing data)
- Active construction sites nearby

**What the data shows**
- What the main sources of noise are in this area
- Whether the noise is mostly during the day or also at night
- Whether the noise comes from one direction — which can matter depending on which side of a building a flat is on

**What this means for renters**
- Road and railway noise is constant but most people get used to it within a few weeks, especially if the windows have good double glazing. It is loudest at street level and reduces on higher floors.
- Noise from bars, restaurants, and late-night venues is different — it tends to happen late at night and at weekends, which makes it harder to get used to. Good windows help less here because noise can come in through gaps around frames or ventilation.
- If the area is under a flight path, noise levels depend heavily on which direction planes are arriving or departing. The same street can be quiet on one side and noisy on the other. Flight paths also shift depending on the season and runway use.

**What to look out for**
- Which direction the main windows face — a flat facing away from the road or rail line will be much quieter
- Whether the windows have double glazing — you can usually tell by looking at the thickness of the frame
- Whether there are any bars or venues directly below or next to the building — check at night before deciding
- Whether there is a construction site nearby that could be active for months or years

**What to do next**
- Visit the area on a Saturday evening between 10pm and midnight if there are late-night venues nearby — this is when noise is usually at its worst
- When you view the property, open and close the windows and listen — a good agent will not mind you doing this
- Ask the landlord or agent directly: "Has noise been raised as an issue by previous tenants?"
- Check the local council's planning portal for nearby construction permits

**Suggested output structure**
```json
{
  "main_noise_sources": ["road traffic", "railway", "late-night venues"],
  "noise_timing": "mostly daytime | constant | mostly at night | weekends only",
  "directional": true,
  "plain_summary": "...",
  "what_this_means": "...",
  "what_to_look_for": ["...", "..."],
  "next_actions": ["...", "..."],
  "viewing_checklist": ["Visit on a Saturday after 22:00", "Listen from inside with windows closed", "Check which direction the main windows face"],
  "data_completeness": "complete | partial | limited"
}
```

---

## Module 7 — Amenities

**Input data**
- Supermarkets within 10-min walk (name, size: large vs. convenience)
- Gyms and fitness facilities within 15-min walk
- Parks and green space (nearest, size, type)
- Cafés within 10-min walk (count)
- Pharmacies within 10-min walk
- Co-working spaces within 15-min walk

**What the data shows**
- How easy it is to do everyday tasks — shopping, picking up medicine, getting fresh air — without leaving the immediate area
- What the area is well set up for and what you would need to travel for
- How the amenity mix fits different kinds of daily routines

**What this means for renters**
- A large supermarket within walking distance is one of the most practical amenities to look for — not because small shops are bad, but because doing a weekly shop at a convenience store costs significantly more per item and limits your choices.
- Having a park or green space nearby matters more than it might seem, especially if you work from home, have a dog, or want somewhere to walk or run without planning a trip.
- Areas with lots of cafés and restaurants are often enjoyable to live in but are not always the best for everyday practicality. It is worth checking separately whether the everyday basics — pharmacy, supermarket, green space — are also nearby.

**What to look out for**
- Whether the nearest supermarket is a large store where you can do a full weekly shop, or a small express store
- Whether the nearest park is a small enclosed space or a larger open area — useful to know if you have a dog or want to run
- Whether there is a pharmacy close enough to reach quickly if you are unwell

**What to do next**
- Walk the route to the nearest large supermarket yourself — maps show distance but not whether the route feels practical
- If you work from home, check whether there is a café or library where you can work occasionally — it makes a difference to daily routine
- If you have a dog or children, visit the nearest park before signing to check whether it suits your needs

**Suggested output structure**
```json
{
  "daily_needs_walkability": "most things within walking distance | some things require a short trip | limited — most things require travel",
  "large_supermarket": { "name": "...", "walk_minutes": 0 },
  "nearest_green_space": { "name": "...", "walk_minutes": 0, "size": "small pocket park | medium park | large open space" },
  "pharmacy_within_10min": true,
  "plain_summary": "...",
  "what_this_means": "...",
  "what_to_look_for": ["...", "..."],
  "next_actions": ["...", "..."],
  "what_the_area_is_good_for": ["...", "..."],
  "what_you_would_need_to_travel_for": ["...", "..."],
  "data_completeness": "complete | partial | limited"
}
```

---

## Localisation

### Principle: generation, not translation

HelloTenant is bilingual (English and Chinese). Chinese content is not produced by translating English output. It is generated independently from a locale-specific `InterpretationRule` that carries different audience assumptions, a different prompt template, and different explanatory depth.

The underlying data — `AreaSnapshot` fields — is the same for both locales. What differs is how that data is interpreted, explained, and turned into guidance for the reader.

### Audience assumptions by locale

**English (`en`)**
The reader is assumed to be familiar with basic UK housing and public services. Concepts like GP registration, Council Tax, and deposit protection do not need to be explained — the guidance can move directly to the practical implication.

**Chinese (`zh`)**
The reader may be renting in the UK for the first time, may be an international student, and may be unfamiliar with UK-specific systems. The `zh` InterpretationRule instructs the AI to explain relevant concepts as part of the generated content — not as a footnote or aside, but woven into the guidance itself.

Concepts that require explanation in `zh` content include:

| Concept | What the zh content should explain |
|---|---|
| GP registration | What a GP is, that international students on a visa of 6+ months can use the NHS, what documents are needed, that registration is free and done in person |
| Council Tax | What it is, that full-time students are usually exempt, how to apply for the exemption, that it is billed to the tenant not the landlord |
| Deposit protection | That landlords are legally required to protect deposits in a government scheme, how to check this after paying, and what to do if they have not |
| Referencing | What a reference check involves (credit history, employment, previous landlord), why it is required, and what international students without UK credit history can expect |
| Guarantors | What a guarantor is, why landlords ask for one, and the common alternative of paying rent in advance |
| Utility bills | That bills (gas, electricity, water, broadband) are typically the tenant's responsibility unless stated otherwise, and how to set up accounts on arrival |

### How localisation is applied per module

Each module's `next_actions` output is the primary place where localisation depth is most visible. The structure is the same across locales; the content is not.

**Example — GP and Healthcare module, next_actions field:**

*English output:*
> Register with a GP as soon as possible after moving in. Bring proof of your new address. If the nearest practices are not accepting patients, call NHS 111.

*Chinese output (generated from zh InterpretationRule):*
> In the UK, a GP (General Practitioner) is your local family doctor. All NHS healthcare starts here — including prescriptions, referrals to hospital, and ongoing health support. If you are in the UK on a student visa of six months or more, you are entitled to use the NHS for free, including GP services.
>
> After moving in, find your nearest GP surgery and go in person to register. Bring your passport, visa, and a document showing your new address (such as your tenancy agreement). Registration is free and usually takes a few minutes. You do not need to be ill to register — doing it early means you are already set up when you need care.
>
> If the nearest surgery is not taking new patients, call NHS 111 (free, available 24 hours) and they can help you find one that is.

The data driving both outputs is identical. The interpretation, framing, and depth differ because the audiences differ.

### What does not change across locales

- `AreaSnapshot` data — locale-agnostic. One snapshot is shared by both locale Recommendations.
- `walk_bucket`, `transit_bucket`, `rank_in_bucket` — structural values derived from spatial data. Identical across locales for the same area/destination pair.
- The four-step module structure (what the data shows / what this means / what to look out for / what to do next) — consistent across locales. The structure is the same; the content within each step differs.

### UI language experience

The user interface detects the user's browser or device language on first visit and defaults to the appropriate locale. Manual language switching is always available. The user's preference is stored and applied on return visits. The page query filters `Recommendation` by locale — no runtime generation occurs on page load.

---

## Cross-module synthesis

Once all modules have run for a given area and destination pair, a synthesis layer produces the top-level Recommendation. This layer should:

- Identify conflicting signals and name them explicitly rather than averaging them away. Example: strong transport links + significant night noise + above-median rent is a coherent profile — name it and describe who it suits.
- Produce a single `area_next_actions` list that consolidates the most important actions across all modules, ranked by urgency (before signing / during viewing / after moving in).
- Flag which modules have limited data so the renter knows where to investigate further themselves.

In Phase 2, when a RenterProfile is active, the synthesis layer adjusts emphasis — for example, weighting the transport module more heavily for a commute-focused profile, or flagging the schools module as lower relevance for renters without children.

---

## Output fields added to every module

Two fields are present in every module output and must always be populated:

**`next_actions`** — a list of 2–4 concrete tasks. Each action specifies when it should be done: before signing, during a viewing, or immediately after moving in. This is the action layer that distinguishes HelloTenant guidance from a data summary.

**`data_completeness`** — one of `complete`, `partial`, or `limited`. When partial or limited, the AI-generated text must soften its language accordingly and tell the renter what to check directly. The module should never present uncertain data as confident fact.
