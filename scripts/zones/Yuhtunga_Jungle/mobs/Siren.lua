-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Siren NM for ROV
-- !pos -406.471 16.683 -378.071 123
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobFight = function(mob, target)
    local clarsachCall = mob:getLocalVar('ClarsachCall')
    if mob:getHPP() <= 25 and clarsachCall == 0 then
        mob:useMobAbility(3515)
        mob:setLocalVar('ClarsachCall', 1)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
