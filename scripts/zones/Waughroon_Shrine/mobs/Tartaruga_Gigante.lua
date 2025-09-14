-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Tartaruga Gigante
-----------------------------------
---@type TMobEntity
local entity = {}

-- Removes any possible debuff when it goes into shell and we have no function that exists for this
local removables =
{
    xi.effect.FLASH,              xi.effect.BLINDNESS,      xi.effect.MAX_HP_DOWN,    xi.effect.MAX_MP_DOWN,
    xi.effect.PARALYSIS,          xi.effect.POISON,         xi.effect.CURSE_I,        xi.effect.CURSE_II,
    xi.effect.DISEASE,            xi.effect.PLAGUE,         xi.effect.WEIGHT,         xi.effect.BIND,
    xi.effect.BIO,                xi.effect.DIA,            xi.effect.BURN,           xi.effect.FROST,
    xi.effect.CHOKE,              xi.effect.RASP,           xi.effect.SHOCK,          xi.effect.DROWN,
    xi.effect.STR_DOWN,           xi.effect.DEX_DOWN,       xi.effect.VIT_DOWN,       xi.effect.AGI_DOWN,
    xi.effect.INT_DOWN,           xi.effect.MND_DOWN,       xi.effect.CHR_DOWN,       xi.effect.ADDLE,
    xi.effect.SLOW,               xi.effect.HELIX,          xi.effect.ACCURACY_DOWN,  xi.effect.ATTACK_DOWN,
    xi.effect.EVASION_DOWN,       xi.effect.DEFENSE_DOWN,   xi.effect.MAGIC_ACC_DOWN, xi.effect.MAGIC_ATK_DOWN,
    xi.effect.MAGIC_EVASION_DOWN, xi.effect.MAGIC_DEF_DOWN, xi.effect.MAX_TP_DOWN,    xi.effect.SILENCE,
    xi.effect.PETRIFICATION
}

local setDmgToChange = function(mob)
    if mob:getHP() > 2000 then
        mob:setLocalVar('dmgToChange', mob:getHP() - 2000)
    else
        mob:setLocalVar('dmgToChange', 0)
    end
end

local intoShell = function(mob)
    for _, effect in ipairs(removables) do
        if mob:hasStatusEffect(effect) then
            mob:delStatusEffect(effect)
        end
    end

    mob:setAnimationSub(1)
    mob:setMobAbilityEnabled(false)
    mob:setAutoAttackEnabled(false)
    mob:setMagicCastingEnabled(true)
    mob:setMod(xi.mod.REGEN, 400)
    mob:setMod(xi.mod.UDMGRANGE, -9500)
    mob:setMod(xi.mod.UDMGPHYS, -9500)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 0)
    mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
    mob:setLocalVar('changeTime', GetSystemTime() + 90)
end

local outOfShell = function(mob)
    mob:setTP(3000)
    mob:setAnimationSub(2)
    mob:setMobAbilityEnabled(true)
    mob:setAutoAttackEnabled(true)
    mob:setMagicCastingEnabled(false)
    mob:setMod(xi.mod.REGEN, 0)
    mob:setMod(xi.mod.UDMGRANGE, 0)
    mob:setMod(xi.mod.UDMGPHYS, 0)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setBehavior(bit.band(mob:getBehavior(), bit.bnot(xi.behavior.NO_TURN)))
end

entity.onMobSpawn = function(mob)
    mob:setMobAbilityEnabled(true)
    mob:setAutoAttackEnabled(true)
    mob:setMagicCastingEnabled(false) -- will not cast until it goes into shell
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 13)
    mob:setMod(xi.mod.REGEN, 0)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
    mob:setMod(xi.mod.DMGMAGIC, -3000)
    mob:setMod(xi.mod.CURSERES, 100)

    setDmgToChange(mob)
    mob:setAnimationSub(2)
end

entity.onMobFight = function(mob, target)
    local changeHP = mob:getLocalVar('dmgToChange')

    if -- In shell
        mob:getAnimationSub() == 1 and
        (GetSystemTime() > mob:getLocalVar('changeTime') or mob:getHPP() == 100)
    then
        setDmgToChange(mob)
        outOfShell(mob)
    end

    if mob:getHP() <= changeHP then
        if mob:getAnimationSub() == 1 then -- In shell
            setDmgToChange(mob)
            outOfShell(mob)
        elseif mob:getAnimationSub() == 2 then -- Out of shell
            setDmgToChange(mob)
            intoShell(mob)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    mob:resetLocalVars()
end

return entity
