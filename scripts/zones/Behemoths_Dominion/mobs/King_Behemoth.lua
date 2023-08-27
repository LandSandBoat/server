-----------------------------------
-- Area: Behemoth's Dominion
--  HNM: King Behemoth
-----------------------------------
local ID = require("scripts/zones/Behemoths_Dominion/IDs")
mixins = { require("scripts/mixins/rage") }
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
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
    mob:setMod(xi.mod.MDEF, 20)
    mob:setMod(xi.mod.ATT, 516)
    mob:setMod(xi.mod.DEF, 500)
    mob:setMod(xi.mod.EVA, 400)
    mob:addMod(xi.mod.GRAVITYRESBUILD, 30)
    mob:setMod(xi.mod.POISONRES, 10)
    mob:setMod(xi.mod.SLOWRES, 10)
    mob:setMod(xi.mod.GRAVITYRES, 10)
    mob:setMod(xi.mod.PARALYZERES, 15)
    mob:setMod(xi.mod.BLINDRES, 15)
    mob:setMod(xi.mod.SLEEPRES, 100)
    mob:setMod(xi.mod.STUNRES, 50)
    mob:setMod(xi.mod.SILENCERES, 100)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 5)
    mob:setLocalVar("delay", os.time())

    -- Despawn the ???
    local questionMarks = GetNPCByID(ID.npc.BEHEMOTH_QM)
    if questionMarks ~= nil then
        questionMarks:setStatus(xi.status.DISAPPEAR)
    end
end

entity.onMobFight = function(mob, target)
    local drawInTableNorth =
    {
        condition1 = target:getXPos() > -180 and target:getZPos() > 53,
        position   = { -182.19, -19.83, 58.34, target:getRotPos() },
    }
    local drawInTableSouth =
    {
        condition1 = target:getXPos() > -230 and target:getZPos() < 5,
        position   = { -235.35, -20.01, -4.47, target:getRotPos() },
    }

    if mob:getHPP() >= 50 then
        mob:setMod(xi.mod.REGAIN, 160)
    elseif mob:getHPP() < 50 and mob:getHPP() > 25 then
        mob:setMod(xi.mod.REGAIN, 100)
    else
        mob:setMod(xi.mod.REGAIN, 80)
    end

    local delay = mob:getLocalVar("delay")
    if os.time() > delay then -- Use Meteor every 40s, based on capture
        mob:castSpell(218, target) -- meteor
        mob:setLocalVar("delay", os.time() + 40)
    end

    utils.arenaDrawIn(mob, target, drawInTableNorth)
    utils.arenaDrawIn(mob, target, drawInTableSouth)
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

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.BEHEMOTH_DETHRONER)
end

entity.onMobDespawn = function(mob)
    -- Respawn the ???
    local questionMarks = GetNPCByID(ID.npc.BEHEMOTH_QM)
    if questionMarks ~= nil then
        questionMarks:updateNPCHideTime(xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
    end
end

return entity
