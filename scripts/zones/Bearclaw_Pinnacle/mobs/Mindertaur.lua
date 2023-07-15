-----------------------------------
-- Area: Bearclaw Pinnacle
--  Mob: Mindertaur
--  ENM: Brothers
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.DMGMAGIC, -1000)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 23)
end

entity.onMobFight = function(mob, target)
    local rayTimer = mob:getLocalVar("rayTimer")
    local rayEnabled = mob:getLocalVar("rayEnabled")

    -- Once partner is dead, use Cthonian Ray every 60-90 seconds
    if os.time() > rayTimer and rayEnabled == 1 and mob:canUseAbilities() then
        mob:setLocalVar("rayTP", mob:getTP())
        mob:setLocalVar("rayTimer", os.time() + math.random(60,90))
        mob:useMobAbility(1359) -- Chthonian Ray
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 1359 then
        mob:setTP(mob:getLocalVar("rayTP"))
    end
end

entity.onMobDeath = function(mob, player, optParams)
    local partner = GetMobByID(mob:getID() - 1)
    if partner:isAlive() then
        partner:setLocalVar("rayEnabled", 1)
    end
end

return entity
