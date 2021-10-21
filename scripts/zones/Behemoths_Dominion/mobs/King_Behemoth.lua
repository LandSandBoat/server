-----------------------------------
-- Area: Behemoth's Dominion
--  HNM: King Behemoth
-----------------------------------
local ID = require("scripts/zones/Behemoths_Dominion/IDs")
mixins = {require("scripts/mixins/rage")}
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/globals/magic")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 60)
end

entity.onMobSpawn = function(mob)
    if xi.settings.LandKingSystem_NQ > 0 or xi.settings.LandKingSystem_HQ > 0 then
        GetNPCByID(ID.npc.BEHEMOTH_QM):setStatus(xi.status.DISAPPEAR)
    end

    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.STUN, {chance = 20, duration = math.random(5, 10)})
end

entity.onSpellPrecast = function(mob, spell)
    if spell:getID() == 218 then
        spell:setAoE(xi.magic.aoe.RADIAL)
        spell:setFlag(xi.magic.spellFlag.HIT_ALL)
        spell:setRadius(30)
        spell:setAnimation(280)
        spell:setMPCost(1)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(xi.title.BEHEMOTH_DETHRONER)
end

entity.onMobDespawn = function(mob)
    -- Set King_Behemoth's Window Open Time
    if xi.settings.LandKingSystem_HQ ~= 1 then
        local wait = 72 * 3600
        SetServerVariable("[POP]King_Behemoth", os.time() + wait) -- 3 days
        if xi.settings.LandKingSystem_HQ == 0 then -- Is time spawn only
            DisallowRespawn(mob:getID(), true)
        end
    end

    -- Set Behemoth's spawnpoint and respawn time (21-24 hours)
    if xi.settings.LandKingSystem_NQ ~= 1 then
        SetServerVariable("[PH]King_Behemoth", 0)
        DisallowRespawn(ID.mob.BEHEMOTH, false)
        UpdateNMSpawnPoint(ID.mob.BEHEMOTH)
        GetMobByID(ID.mob.BEHEMOTH):setRespawnTime(75600 + math.random(0, 6) * 1800) -- 21 - 24 hours with half hour windows
    end
end

return entity
