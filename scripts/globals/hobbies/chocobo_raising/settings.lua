-----------------------------------
-- Chocobo Raising - Settings
-- Values a server may change, as modules/custom/lua/chocobo_raising_qol.lua does. Retail values are in constants.lua.
-----------------------------------
xi = xi or {}
xi.chocoboRaising = xi.chocoboRaising or {}

-----------------------------------
-- Constants
-----------------------------------
-- Seconds per raising day: 86400 is one Earth day, 27648 one Vana'diel week, 3456 one Vana'diel day.
xi.chocoboRaising.dayLength = 86400

-- The day each stage starts.
xi.chocoboRaising.daysToChick      = 4
xi.chocoboRaising.daysToAdolescent = 19
xi.chocoboRaising.daysToAdult1     = 29
xi.chocoboRaising.daysToAdult2     = 43  -- Best time to improve attributes
xi.chocoboRaising.daysToAdult3     = 64  -- Growth stabilises
xi.chocoboRaising.daysToAdult4     = 129 -- Retirement

-- Stat changes and care plan pay are multiplied by these.
xi.chocoboRaising.statPositiveMultiplier = 1.0
xi.chocoboRaising.statNegativeMultiplier = 1.0
xi.chocoboRaising.gilMultiplier          = 1.0

-- True keeps an adult ageing past the retirement day; the player can still retire it.
xi.chocoboRaising.disableRetirement = false

-- The four stats together stop growing here; 0 lifts the cap. Each stat still stops at 255 (SS).
xi.chocoboRaising.statGrowthCap = 640

-- Riding speed and minutes. Grades run from F (0 ranks) to SS (+7 ranks); an ability and silks reach +9.
-- Gallop and Purple Racing Silks add a speed rank; Canter and Red Racing Silks a time rank.
-- Speeds are percent of a rental (map.MOUNT_SPEED). At the default cap of 100 an SS STR chocobo with
-- Gallop, or with Purple Race Silks, matches a rental, as the guides say. A higher cap such as 105 lets
-- SS STR with Gallop and the silks ride slightly faster than a rental (102.5).
xi.chocoboRaising.ridingSpeedBase    = 80
xi.chocoboRaising.ridingSpeedPerRank = 2.5
xi.chocoboRaising.ridingSpeedCap     = 100

xi.chocoboRaising.ridingTimeBase    = 17
xi.chocoboRaising.ridingTimePerRank = 4
xi.chocoboRaising.ridingTimeCap     = 45
