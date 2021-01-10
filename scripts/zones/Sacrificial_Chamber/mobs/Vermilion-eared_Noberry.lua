-----------------------------------
-- Area: Sacrificial Chamber
--  Mob: Vermilion-eared Noberry
-- BCNM: Jungle Boogymen
-----------------------------------
mixins =
{
    require("scripts/mixins/families/tonberry"),
    require("scripts/mixins/job_special")
}
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    local elementalId = mob:getID() + 1
    if GetMobByID(elementalId):isSpawned() then
        DespawnMob(elementalId)
    end
end

return entity
