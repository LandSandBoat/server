-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Time Bomb
-- BCNM: 3, 2, 1...
-----------------------------------
local entity = {}

function onMobEngaged(mob, target)
    mob:setLocalVar("selfDestruct", os.time() + 60)
    mob:SetAutoAttackEnabled(false)
    mob:SetMobAbilityEnabled(false)
end

entity.onMobFight = function(mob, target)
    if os.time() > mob:getLocalVar("selfDestruct") then
        mob:useMobAbility(256) -- self-destruct_321
    end
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 256 then
        mob:timer(1000, function(mob)
            mob:getBattlefield():lose()
        end)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
