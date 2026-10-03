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

-- Speed is a percent of map.MOUNT_SPEED. Gallop and Purple Racing Silks each add a rank.
xi.chocoboRaising.ridingSpeedBase    = 80
xi.chocoboRaising.ridingSpeedPerRank = 2.5
xi.chocoboRaising.ridingSpeedMaxRank = 8

-- Minutes. Canter and Red Racing Silks each add a rank.
xi.chocoboRaising.ridingTimeBase    = 17
xi.chocoboRaising.ridingTimePerRank = 4
xi.chocoboRaising.ridingTimeMaxRank = 7
