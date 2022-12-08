-----------------------------------
-- func: defmode
-- desc: Toggles defensive mode on the player, granting them several special abilities. The idea is to just not die, but not be a god offensively.
-- Pass variable of 1 to command to enable a "soft" god mode.
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "i"
}

local def_mode_on = function(player)
    -- Add bonus effects to the player..
    player:addStatusEffect(xi.effect.MAX_HP_BOOST, 1000, 0, 0)
    player:addStatusEffect(xi.effect.MAX_MP_BOOST, 1000, 0, 0)
    player:addStatusEffect(xi.effect.CHAINSPELL, 1, 0, 0)
    player:addStatusEffect(xi.effect.PERFECT_DODGE, 1, 0, 0)
    player:addStatusEffect(xi.effect.INVINCIBLE, 1, 0, 0)
    player:addStatusEffect(xi.effect.ELEMENTAL_SFORZO, 1, 0, 0)
    player:addStatusEffect(xi.effect.PERFECT_DEFENSE, 10000, 0, 0)
    player:addStatusEffect(xi.effect.MANAFONT, 1, 0, 0)
    player:addStatusEffect(xi.effect.REGAIN, 300, 0, 0)
    player:addStatusEffect(xi.effect.REFRESH, 99, 0, 0)
    player:addStatusEffect(xi.effect.REGEN, 99, 0, 0)

    -- Add bonus mods to the player..
    player:addMod(xi.mod.RDEF, 2500)
    player:addMod(xi.mod.DEF, 2500)
    player:addMod(xi.mod.MDEF, 2500)

    -- Heal the player from the new buffs..
    player:addHP(50000)
    player:setMP(50000)
end

local def_mode_off = function(player)
    -- Remove bonus effects..
    player:delStatusEffect(xi.effect.MAX_HP_BOOST)
    player:delStatusEffect(xi.effect.MAX_MP_BOOST)
    player:delStatusEffect(xi.effect.CHAINSPELL)
    player:delStatusEffect(xi.effect.PERFECT_DODGE)
    player:delStatusEffect(xi.effect.INVINCIBLE)
    player:delStatusEffect(xi.effect.ELEMENTAL_SFORZO)
    player:delStatusEffect(xi.effect.PERFECT_DEFENSE)
    player:delStatusEffect(xi.effect.MANAFONT)
    player:delStatusEffect(xi.effect.REGAIN)
    player:delStatusEffect(xi.effect.REFRESH)
    player:delStatusEffect(xi.effect.REGEN)

    -- Remove bonus mods..
    player:delMod(xi.mod.RDEF, 2500)
    player:delMod(xi.mod.DEF, 2500)
    player:delMod(xi.mod.MDEF, 2500)
end

function onTrigger(player)
    local state = player:getCharVar("DefMode")
    if state == 0 then
        player:setCharVar("DefMode", 1)
        def_mode_on(player)
        player:PrintToPlayer("Def Mode enabled.")
    elseif state == 1 then
        player:setCharVar("DefMode", 0)
        def_mode_off(player)
        player:PrintToPlayer("Def Mode disabled.")
    end
end
