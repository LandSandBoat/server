-----------------------------------
-- Area: Garlaige Citadel
--   NM: Chandelier
-- Note: Spawned for quest "Hitting the Marquisate"
-----------------------------------
local ID = zones[xi.zone.GARLAIGE_CITADEL]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 120)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 400)
end

entity.onMobEngage = function(mob, target)
    local ce = mob:getCE(target)
    local ve = mob:getVE(target)
    if ce == 0 and ve == 0 then
        mob:setMobMod(xi.mobMod.NO_DROPS, 1)
        mob:useMobAbility(xi.mobSkill.SELF_DESTRUCT_BOMB) -- Chandelier's self-destruct is similar to Volcanic Bomb's with a 1600ish cap and should be adjusted accordingly when its rewritten
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    return xi.mobSkill.BERSERK_BOMB
end

entity.onMobDeath = function(mob, player, optParams)
    GetNPCByID(ID.npc.CHANDELIER_QM):setLocalVar('chandelierCooldown', GetSystemTime() + 600) -- 10 minute timeout
end

return entity
