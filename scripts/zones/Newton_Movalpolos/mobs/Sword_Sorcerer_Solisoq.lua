-----------------------------------
-- Area: Newton Movalpolos
--   NM: Sword Sorcerer Solisoq
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar("chainCount", 1)
end

entity.onMobFight = function(mob, player)
    -- Uses Chainspell every 25%
    local chainCount = mob:getLocalVar("chainCount")
    local hpTrigger = { 75, 50, 25 }
    for k, v in pairs(hpTrigger) do
        if
            mob:getHPP() <= v and
            chainCount == k and
            not mob:hasStatusEffect(xi.effect.CHAINSPELL)
        then
            mob:useMobAbility(692)
            mob:setLocalVar("chainCount", chainCount + 1)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 249)
end

return entity
