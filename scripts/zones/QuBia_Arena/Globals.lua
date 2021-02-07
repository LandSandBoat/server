-----------------------------------
-- Area: QuBia_Arena
-- Globals
-----------------------------------
local ID = require("scripts/zones/QuBia_Arena/IDs")

-----------------------------------
-- Mission 9-2 SANDO
-- BCNM: Heir to the light
-----------------------------------
function phaseChangeReady(battlefield)
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
