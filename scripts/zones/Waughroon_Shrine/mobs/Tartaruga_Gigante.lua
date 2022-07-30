-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Tartaruga Gigante
-----------------------------------
local ID = require("scripts/zones/Waughroon_Shrine/IDs")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

-- Removes any possible debuff when it goes into shell and we have no function that exists for this
local removables = {xi.effect.FLASH, xi.effect.BLINDNESS, xi.effect.MAX_HP_DOWN, xi.effect.MAX_MP_DOWN, xi.effect.PARALYSIS, xi.effect.POISON,
                    xi.effect.CURSE_I, xi.effect.CURSE_II, xi.effect.DISEASE, xi.effect.PLAGUE, xi.effect.WEIGHT, xi.effect.BIND,
                    xi.effect.BIO, xi.effect.DIA, xi.effect.BURN, xi.effect.FROST, xi.effect.CHOKE, xi.effect.RASP, xi.effect.SHOCK, xi.effect.DROWN,
                    xi.effect.STR_DOWN, xi.effect.DEX_DOWN, xi.effect.VIT_DOWN, xi.effect.AGI_DOWN, xi.effect.INT_DOWN, xi.effect.MND_DOWN,
                    xi.effect.CHR_DOWN, xi.effect.ADDLE, xi.effect.SLOW, xi.effect.HELIX, xi.effect.ACCURACY_DOWN, xi.effect.ATTACK_DOWN,
                    xi.effect.EVASION_DOWN, xi.effect.DEFENSE_DOWN, xi.effect.MAGIC_ACC_DOWN, xi.effect.MAGIC_ATK_DOWN, xi.effect.MAGIC_EVASION_DOWN,
                    xi.effect.MAGIC_DEF_DOWN, xi.effect.MAX_TP_DOWN, xi.effect.SILENCE}

local intoShell = function(mob)
    for _, effect in ipairs(removables) do
        if (mob:hasStatusEffect(effect)) then
            mob:delStatusEffect(effect)
        end
    end
    mob:setAnimationSub(1)
    mob:SetMobAbilityEnabled(false)
    mob:SetAutoAttackEnabled(false)
    mob:SetMagicCastingEnabled(true)
    mob:setMod(xi.mod.REGEN, 400)
    mob:setMod(xi.mod.UDMGRANGE, -9500)
    mob:setMod(xi.mod.UDMGPHYS, -9500)
    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.STANDBACK))
    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
end

local outOfShell = function(mob)
    mob:setTP(3000)
    mob:setAnimationSub(2)
    mob:SetMobAbilityEnabled(true)
    mob:SetAutoAttackEnabled(true)
    mob:SetMagicCastingEnabled(false)
    mob:setMod(xi.mod.REGEN, 0)
    mob:setMod(xi.mod.UDMGRANGE, 0)
    mob:setMod(xi.mod.UDMGPHYS, 0)
    mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(xi.behavior.STANDBACK)))
    mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(xi.behavior.NO_TURN)))
    mob:setLocalVar("DamageTaken", 0)
end

entity.onMobSpawn = function(mob)
    mob:setAnimationSub(0)
    mob:SetMobAbilityEnabled(true)
    mob:SetAutoAttackEnabled(true)
    mob:SetMagicCastingEnabled(false) -- will not cast until it goes into shell
    mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(xi.behavior.STANDBACK)))
    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 13)
    mob:setMod(xi.mod.REGEN, 0)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
    mob:setMod(xi.mod.DMGMAGIC, -3000)
    mob:setMod(xi.mod.CURSERES, 100)
    local changeHP = mob:getHP() - 2000 -- 5% of Max HP
    mob:setLocalVar("changeHP", changeHP)
    mob:setLocalVar("DamageTaken", 0)

    -- Forced out of shell after taking 4000 total damage
    mob:addListener("TAKE_DAMAGE", "TARTARUGA_TAKE_DAMAGE", function(mobArg, amount, attacker, attackType, damageType)
        local damageTaken = mobArg:getLocalVar("DamageTaken")
        local waitTime = mobArg:getLocalVar("waitTime")
        damageTaken = damageTaken + amount

        if damageTaken > 4000 then
            if mobArg:getAnimationSub() == 1 and os.time() > waitTime then
                mobArg:setAnimationSub(2)
                local changeDamage = (mobArg:getHP() - amount) - 2000
                mobArg:setLocalVar("changeHP", changeDamage)
                mobArg:setLocalVar("waitTime", os.time() + 2)
                outOfShell(mobArg)
            end
        elseif os.time() > waitTime then
            mobArg:setLocalVar("DamageTaken", damageTaken)
        end
    end)
end

entity.onMobFight = function(mob, target)
    local changeHP = mob:getLocalVar("changeHP")
    local waitTime = mob:getLocalVar("waitTime")

    if mob:getHP() <= changeHP and (mob:getAnimationSub() == 2 or mob:getAnimationSub() == 0) and os.time() > waitTime then
        mob:setLocalVar("DamageTaken", 0)
        mob:setAnimationSub(1)
        mob:setLocalVar("waitTime", os.time() + 2)
        intoShell(mob)
    elseif mob:getHPP() == 100 and mob:getAnimationSub() == 1 and os.time() > waitTime then
        mob:setLocalVar("DamageTaken", 0)
        mob:setAnimationSub(2)
        changeHP = mob:getHP() - 2000
        mob:setLocalVar("changeHP", changeHP)
        mob:setLocalVar("waitTime", os.time() + 2)
        outOfShell(mob)
    end
end

entity.onMobDespawn = function(mob)
    mob:resetLocalVars()
    mob:removeListener("TARTARUGA_TAKE_DAMAGE")
end

return entity
