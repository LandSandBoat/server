-----------------------------------
-- Area: Bearclaw Pinnacle
--  Mob: Eldertaur
--  ENM: Brothers
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.DRAW_IN, 1)
    mob:setMobMod(xi.mobMod.DRAW_IN_CUSTOM_RANGE, 40)
    mob:setMod(xi.mod.DMGMAGIC, -1000)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 23)
end

entity.onMobFight = function(mob, target)
    local rayTimer = mob:getLocalVar("rayTimer")
    local rayEnabled = mob:getLocalVar("rayEnabled")

    -- Once partner is dead, use Apocalyptic Ray every 60-90 seconds
    if os.time() > rayTimer and rayEnabled == 1 and mob:canUseAbilities() then
        mob:setLocalVar("rayTP", mob:getTP())
        mob:setLocalVar("rayTimer", os.time() + math.random(60,90))
        mob:useMobAbility(1360) -- Apocalyptic Ray
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 1360 then
        mob:setTP(mob:getLocalVar("rayTP"))
    end
end

entity.onMobDeath = function(mob, player, optParams)
    local partner = GetMobByID(mob:getID() + 1)
    if partner:isAlive() then
        partner:setLocalVar("rayEnabled", 1)
    end
end

return entity
