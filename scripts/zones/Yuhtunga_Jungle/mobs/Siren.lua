-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Siren NM for ROV
-- !pos -406.471 16.683 -378.071 123
-----------------------------------
local ID = require("scripts/zones/Yuhtunga_Jungle/IDs")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobFight(mob, target)
    local ClarsachCall = mob:getLocalVar("ClarsachCall")
    if mob:getHPP() <= 25 and ClarsachCall == 0 then
        mob:useMobAbility(3515)
        mob:setLocalVar("ClarsachCall", 1)
    end
end

function onMobDeath(mob, player, isKiller)
    local party = player:getParty()
    for _, member in ipairs(party) do
        if member:getCurrentMission(ROV) == tpz.mission.id.rov.THE_LOST_AVATAR then
            player:setCharVar("RhapsodiesStatus", 1)
        end
    end
end
