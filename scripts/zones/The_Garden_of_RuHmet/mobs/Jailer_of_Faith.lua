-----------------------------------
-- Area: The Garden of Ru'Hmet
--   NM: Jailer of Faith
-----------------------------------
local ID = require("scripts/zones/The_Garden_of_RuHmet/IDs")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local entity = {}

-- Jailer of Faith takes extra damage when flower is open
local openFlower = function(mob)
    mob:setLocalVar("PhysicalDamage", 0)
    mob:setLocalVar("MagicalDamage", 0)
    mob:setLocalVar("RangedDamage", 0)
    mob:setLocalVar("BreathDamage", 0)
    mob:delMod(xi.mod.ATTP, 10)
    mob:setMod(xi.mod.HTH_SDT, 1250)
    mob:setMod(xi.mod.SLASH_SDT, 1250)
    mob:setMod(xi.mod.PIERCE_SDT, 1250)
    mob:setMod(xi.mod.IMPACT_SDT, 1250)
    mob:setMod(xi.mod.DMGPHYS, 112)
    mob:setMod(xi.mod.DMGMAGIC, 112)
    mob:setMod(xi.mod.DMGRANGE, 112)
    mob:setMod(xi.mod.DMGBREATH, 112)
    mob:setAnimationSub(2)
end

-- Jailer of Faith takes reduced damage while flower is closed
local closeFlower = function(mob)
    mob:setLocalVar("PhysicalDamage", 0)
    mob:setLocalVar("MagicalDamage", 0)
    mob:setLocalVar("RangedDamage", 0)
    mob:setLocalVar("BreathDamage", 0)
    mob:addMod(xi.mod.ATTP, 10) -- hits harder while flower is closed
    mob:setMod(xi.mod.HTH_SDT, 750)
    mob:setMod(xi.mod.SLASH_SDT, 750)
    mob:setMod(xi.mod.PIERCE_SDT, 750)
    mob:setMod(xi.mod.IMPACT_SDT, 750)
    mob:setMod(xi.mod.DMGPHYS,  75)
    mob:setMod(xi.mod.DMGMAGIC, 75)
    mob:setMod(xi.mod.DMGRANGE, 75)
    mob:setMod(xi.mod.DMGBREATH, 75)
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
    mob:setLocalVar("PhysicalDamage", 0)
    mob:setLocalVar("MagicalDamage", 0)
    mob:setLocalVar("RangedDamage", 0)
    mob:setLocalVar("BreathDamage", 0)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            {
                id = xi.jsa.MANAFONT,
                endCode = function(mobArg) -- Uses Manafont and casts Quake II -- only casts this during manafont.
                    mobArg:castSpell(211) -- quake II
                end,
            },
        },
    })
    -- Change animation to open
    mob:AnimationSub(2)
    mob:setMobMod(xi.mobMod.HP_STANDBACK, 0)
    mob:setMod(xi.mod.FASTCAST, 30) -- taken from timing of spells from multiple captures
    mob:setMod(xi.mod.DEF, 450)
end

entity.onMobFight = function(mob)
    mob:addListener("COMBAT_TICK", "FAITH_CTICK", function(mobArg)
        local sum = mobArg:getLocalVar("PhysicalDamage") + mobArg:getLocalVar("MagicalDamage") + mobArg:getLocalVar("RangedDamage") + mobArg:getLocalVar("BreathDamage")
        if mobArg:getAnimationSub() == 2 and sum > 1500 then -- Faith will close flower upon taking 1500 damage combined.
            closeFlower(mobArg)
        elseif mobArg:getAnimationSub() <= 1 and mobArg:getBattleTime() > mobArg:getLocalVar("[faith]changeTime") then
            openFlower(mobArg)
        else
            -- if no dmg taken - dont trigger a change
        end
    end)
end

entity.onMagicCastingCheck = function(mob, target, spell)
    local rnd = math.random()
    if rnd < 0.5 and mob:hasStatusEffect(xi.effect.MANAFONT) == true then -- quake II replaces existing earth damage spells during manafont
        return 211 -- quake II casted exclusively while Manafont is active.
    elseif rnd < 0.25 then
        return 162 -- stone iv
    elseif rnd < 0.5 then
        return 191 -- stonega iii
    elseif rnd < 0.75 then
        return 365 -- breakga'
    else
        return 357 -- slowga
    end
end

entity.onMobEngaged = function(mob, target)
    mob:setLocalVar("[faith]changeTime", 0)
end

entity.onMobDeath = function(mob)
end

entity.onMobDespawn = function(mob)
    -- Move QM to random location
    GetNPCByID(ID.npc.QM_JAILER_OF_FAITH):setPos(unpack(ID.npc.QM_JAILER_OF_FAITH_POS[math.random(1, 5)]))
end

return entity
