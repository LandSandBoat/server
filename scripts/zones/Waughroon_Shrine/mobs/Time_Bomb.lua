-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Time Bomb
-- BCNM: 3, 2, 1...
-----------------------------------
local entity = {}

entity.onMobEngaged = function(mob, target)
    mob:setLocalVar("selfDestruct", os.time() + 60)
    mob:SetAutoAttackEnabled(false)
    mob:SetMobAbilityEnabled(false)
end

entity.onMobFight = function(mob, target)
    if os.time() > mob:getLocalVar("selfDestruct") then
        mob:useMobAbility(256) -- self-destruct_321
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 256 then
        mob:timer(1000, function(mobArg)
            mobArg:getBattlefield():lose()
        end)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
