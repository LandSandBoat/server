-----------------------------------
-- Area: QuBia_Arena
-- Globals
-----------------------------------
local ID = require("scripts/zones/QuBia_Arena/IDs")
local global = {}

-----------------------------------
-- Mission 9-2 SANDO
-- BCNM: Heir to the light
-----------------------------------

global.phaseChangeReady = function(battlefield)
    local inst = battlefield:getArea()
    printf("AreaID %i ", inst)
    local instOffset = ID.mob.HEIR_TO_THE_LIGHT_OFFSET + (14 * (inst-1))
    for i = instOffset + 3, instOffset + 13 do
        printf("MobID %i isDead => %s ",i, GetMobByID(i):isDead() and 'T' or 'F')
        if not GetMobByID(i):isDead() then
            return false
        end
    end
    return true
end

return global
