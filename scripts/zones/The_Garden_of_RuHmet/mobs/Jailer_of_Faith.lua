-----------------------------------
-- Area: The Garden of Ru'Hmet
--   NM: Jailer of Faith
-----------------------------------
local ID = require("scripts/zones/The_Garden_of_RuHmet/IDs")
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

-- Jailer of Faith takes double damage when flower is open
local openFlower = function(mob)
    mob:setLocalVar("PhysicalDamage", 0)
    mob:setLocalVar("MagicalDamage", 0)
    mob:setLocalVar("RangedDamage", 0)
    mob:setLocalVar("BreathDamage", 0)
    mob:delMod(xi.mod.ATTP, 10)
    mob:setMod(xi.mod.DMGPHYS, 10000)
    mob:setMod(xi.mod.DMGMAGIC, 10000)
    mob:setMod(xi.mod.DMGRANGE, 10000)
    mob:setMod(xi.mod.DMGBREATH, 10000)
    mob:setAnimationSub(2)
end

-- Jailer of Faith takes normal damage while flower is closed
local closeFlower = function(mob)
    mob:setLocalVar("PhysicalDamage", 0)
    mob:setLocalVar("MagicalDamage", 0)
    mob:setLocalVar("RangedDamage", 0)
    mob:setLocalVar("BreathDamage", 0)
    mob:addMod(xi.mod.ATTP, 10) -- hits harder while flower is closed
    mob:setMod(xi.mod.DMGPHYS, 0)
    mob:setMod(xi.mod.DMGMAGIC, 0)
    mob:setMod(xi.mod.DMGRANGE, 0)
    mob:setMod(xi.mod.DMGBREATH, 0)
    mob:setLocalVar("[faith]changeTime", mob:getBattleTime() + math.random(20, 40))
    mob:setAnimationSub(1)
end

entity.onMobInitialize = function(mob)
    mob:addListener("TAKE_DAMAGE", "FAITH_TAKE_DAMAGE", function(mobArg, amount, attacker, attackType, damageType)
        if attackType == xi.attackType.PHYSICAL then
            mobArg:setLocalVar("PhysicalDamage", mobArg:getLocalVar("PhysicalDamage") + amount)
        elseif attackType == xi.attackType.MAGICAL then
            mobArg:setLocalVar("MagicalDamage", mobArg:getLocalVar("MagicalDamage") + amount)
        elseif attackType == xi.attackType.RANGED then
            mobArg:setLocalVar("RangedDamage", mobArg:getLocalVar("RangedDamage") + amount)
        elseif attackType == xi.attackType.BREATH then
            mobArg:setLocalVar("BreathDamage", mobArg:getLocalVar("BreathDamage") + amount)
        else
            -- ignore Untyped Damage
        end
    end)
end

entity.onMobSpawn = function(mob)
    -- Observed to use manafont at 80/50/25% HP
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            {
                id = xi.jsa.MANAFONT,
                hpp = 80,
                endCode = function(mobArg)
                    mobArg:castSpell(xi.magic.spell.QUAKE_II, mobArg:getTarget())
                end,
            },
            {
                id = xi.jsa.MANAFONT,
                hpp = 50,
                endCode = function(mobArg)
                    mobArg:castSpell(xi.magic.spell.QUAKE_II, mobArg:getTarget())
                end,
            },
            {
                id = xi.jsa.MANAFONT,
                hpp = 25,
                endCode = function(mobArg)
                    mobArg:castSpell(xi.magic.spell.QUAKE_II, mobArg:getTarget())
                end,
            },
        },
    })
    -- Change animation to open
    mob:setAnimationSub(2)
    mob:setMobMod(xi.mobMod.HP_STANDBACK, 0)
    mob:setMod(xi.mod.FASTCAST, 30) -- taken from timing of spells from multiple captures
    mob:setMod(xi.mod.ATT, 450)
    mob:setMod(xi.mod.DEF, 409)
    mob:setMod(xi.mod.EVA, 325)
end

entity.onMobFight = function(mob)
    mob:addListener("COMBAT_TICK", "FAITH_CTICK", function(mobArg)
        local sum = mobArg:getLocalVar("PhysicalDamage") + mobArg:getLocalVar("MagicalDamage") + mobArg:getLocalVar("RangedDamage") + mobArg:getLocalVar("BreathDamage")
        if mobArg:getAnimationSub() == 2 and sum > 1500 then -- Faith will close flower upon taking 1500 damage combined.
            closeFlower(mobArg)
        elseif
            mobArg:getAnimationSub() <= 1 and
            mobArg:getBattleTime() > mobArg:getLocalVar("[faith]changeTime")
        then
            openFlower(mobArg)
        else
            -- if no dmg taken - dont trigger a change
        end
    end)
end

entity.onMobMagicPrepare = function(mob, target, spell)
    if mob:hasStatusEffect(xi.effect.MANAFONT) and math.random() < 0.5 then
        return xi.magic.spell.QUAKE_II
    end
end

entity.onMobEngaged = function(mob, target)
    mob:setLocalVar("[faith]changeTime", 0)
end

entity.onMobDeath = function(mob)
end

entity.onMobDespawn = function(mob)
    local qmFaith = GetNPCByID(ID.npc.QM_JAILER_OF_FAITH)
    qmFaith:setLocalVar("nextMove", os.time() + 1800 + xi.settings.main.FORCE_SPAWN_QM_RESET_TIME) -- 30 minutes from the time the QM respawns
    -- Move QM to random location
    GetNPCByID(ID.npc.QM_JAILER_OF_FAITH):setPos(unpack(ID.npc.QM_JAILER_OF_FAITH_POS[math.random(1, 5)]))
end

return entity
