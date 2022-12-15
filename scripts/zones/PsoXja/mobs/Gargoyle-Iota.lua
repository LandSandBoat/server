-----------------------------------
-- Area: Pso'Xja
--  Mob: Gargoyle-Iota
-----------------------------------
local ID = require("scripts/zones/PsoXja/IDs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    if not mob:hasStatusEffect(xi.effect.MAGIC_SHIELD) then
        mob:addStatusEffect(xi.effect.MAGIC_SHIELD, 1, 0, 0)
    end
    mob:setMod(xi.mod.UDMGBREATH, -10000)
    mob:setMod(xi.mobMod.DETECTION, bit.bor(xi.detects.SIGHT, xi.detects.MAGIC, xi.detects.SCENT))
    mob:setLocalVar("immunity", 1)
    mob:setLocalVar("timer", os.time() + 30)
end

entity.onMobFight = function(mob)
    local timer = mob:getLocalVar("timer")
    local immunity = mob:getLocalVar("immunity")
    if os.time() > timer and immunity == 1 then -- blue: Immune to phys damage
        mob:setLocalVar("twohour_tp", mob:getTP())
        mob:useMobAbility(624)
        if mob:hasStatusEffect(xi.effect.MAGIC_SHIELD) then
            mob:delStatusEffectSilent(xi.effect.MAGIC_SHIELD)
        end
        mob:setMod(xi.mod.UDMGBREATH, 0)
        mob:setMod(xi.mod.UDMGPHYS, -10000)
        mob:setMod(xi.mod.UDMGRANGE, -10000)
        mob:setLocalVar("immunity", 0)
        mob:setLocalVar("timer", os.time() + 30)
    elseif os.time() > timer and immunity == 0 then -- yellow: Immune to magical damage
        mob:setLocalVar("twohour_tp", mob:getTP())
        mob:useMobAbility(625)
        if not mob:hasStatusEffect(xi.effect.MAGIC_SHIELD) then
            mob:addStatusEffect(xi.effect.MAGIC_SHIELD, 1, 0, 0)
        end
        mob:setMod(xi.mod.UDMGBREATH, -10000)
        mob:setMod(xi.mod.UDMGPHYS, 0)
        mob:setMod(xi.mod.UDMGRANGE, 0)
        mob:setLocalVar("immunity", 1)
        mob:setLocalVar("timer", os.time() + 30)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 624 or skill:getID() == 625 then
        mob:addTP(mob:getLocalVar("twohour_tp"))
        mob:setLocalVar("twohour_tp", 0)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    local partner = mob:getID() + 1
    if optParams.isKiller and not GetMobByID(partner):isAlive() then
        GetNPCByID(ID.npc.BLUE_BRACELET_DOOR):setAnimation(8)
        for _, member in pairs(player:getAlliance()) do
            member:setLocalVar("blueKilled", 1)
        end
    end
end

entity.onMobDespawn = function(mob)
    local partner = mob:getID() + 1
    local blueDoor = GetNPCByID(ID.npc.BLUE_BRACELET_DOOR)
    if blueDoor:getAnimation() == 9 and not GetMobByID(partner):isAlive() then
        blueDoor:setAnimation(8)
    end
end

return entity
