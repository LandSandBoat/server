-----------------------------------
-- Area: Behemoth's Dominion
--  HNM: King Behemoth
-----------------------------------
local ID = require("scripts/zones/Behemoths_Dominion/IDs")
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/settings")
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
    if xi.settings.main.LandKingSystem_NQ > 0 or xi.settings.main.LandKingSystem_HQ > 0 then
        GetNPCByID(ID.npc.BEHEMOTH_QM):setStatus(xi.status.DISAPPEAR)
        mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
        SetDropRate(1450, 1527, 150) -- 15% drop rate on behemoth tongue
    end

    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
    mob:setMod(xi.mod.MDEF, 20)
    mob:addMod(xi.mod.ATT, 150)
    mob:addMod(xi.mod.DEF, 200)
    mob:addMod(xi.mod.EVA, 110)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 5)
end

entity.onMobFight = function(mob, target)
    if mob:getHPP() >= 50 then
        mob:setMod(xi.mod.REGAIN, 160)
    elseif mob:getHPP() < 50 and mob:getHPP() > 25 then
        mob:setMod(xi.mod.REGAIN, 100)
    else
        mob:setMod(xi.mod.REGAIN, 80)
    end

    local delay = mob:getLocalVar("delay")
    if os.time() > delay then -- Use Meteor every 40s, based on capture
        mob:castSpell(218) -- meteor
        mob:setLocalVar("delay", os.time() + 40)
    end

    local drawInWait = mob:getLocalVar("DrawInWait")

    if (target:getXPos() > -180 and target:getZPos() > 53) and os.time() > drawInWait then -- North Tunnel Draw In
        local rot = target:getRotPos()
        target:setPos(-182.19,-19.83,58.34,rot)
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar("DrawInWait", os.time() + 2)
    elseif (target:getXPos() > -230 and target:getZPos() < 5) and os.time() > drawInWait then  -- South Tunnel Draw In
        local rot = target:getRotPos()
        target:setPos(-235.35,-20.01,-4.47,rot)
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar("DrawInWait", os.time() + 2)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    local params = {}
    params.chance = 20
    params.duration = math.random(4, 8) -- Based on captures
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.STUN, params)
end

entity.onSpellPrecast = function(mob, spell)
    if spell:getID() == 218 then
        spell:setAoE(xi.magic.aoe.RADIAL)
        spell:setFlag(xi.magic.spellFlag.HIT_ALL)
        spell:setRadius(30)
        spell:setAnimation(280)
        spell:setMPCost(0)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(xi.title.BEHEMOTH_DETHRONER)
end

entity.onMobDespawn = function(mob)
    -- Set King_Behemoth's Window Open Time
    if xi.settings.main.LandKingSystem_HQ ~= 1 then
        local wait = 72 * 3600
        SetServerVariable("[POP]King_Behemoth", os.time() + wait) -- 3 days
        if xi.settings.main.LandKingSystem_HQ == 0 then -- Is time spawn only
            DisallowRespawn(mob:getID(), true)
        end
    end

    -- Set Behemoth's spawnpoint and respawn time (21-24 hours)
    if xi.settings.main.LandKingSystem_NQ ~= 1 then
        SetServerVariable("[PH]King_Behemoth", 0)
        DisallowRespawn(ID.mob.BEHEMOTH, false)
        UpdateNMSpawnPoint(ID.mob.BEHEMOTH)
        GetMobByID(ID.mob.BEHEMOTH):setRespawnTime(75600 + math.random(0, 6) * 1800) -- 21 - 24 hours with half hour windows
    end
    -- Respawn the ???
    if xi.settings.main.LandKingSystem_HQ == 2 or xi.settings.main.LandKingSystem_NQ == 2 then
        GetNPCByID(ID.npc.BEHEMOTH_QM):updateNPCHideTime(xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
    end
end

return entity
