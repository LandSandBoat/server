---------------------------------------------------------------------------------------------------
-- func: petgodmode
-- desc: Toggles god mode on the player's pet, granting them several special abilities.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = ""
}

function onTrigger(player)
    local pet = player:getPet()
    if (pet and pet:getLocalVar("GodMode") == 0) then
        -- Toggle GodMode on..
        pet:setLocalVar("GodMode", 1)

        -- Add bonus effects to the pet..
        pet:addStatusEffect(tpz.effect.MAX_HP_BOOST, 1000, 0, 0)
        pet:addStatusEffect(tpz.effect.MAX_MP_BOOST, 1000, 0, 0)
        pet:addStatusEffect(tpz.effect.SENTINEL, 100, 0, 0)
        pet:addStatusEffect(tpz.effect.MIGHTY_STRIKES, 1, 0, 0)
        pet:addStatusEffect(tpz.effect.HUNDRED_FISTS, 1, 0, 0)
        pet:addStatusEffect(tpz.effect.CHAINSPELL, 1, 0, 0)
        pet:addStatusEffect(tpz.effect.PERFECT_DODGE, 1, 0, 0)
        pet:addStatusEffect(tpz.effect.INVINCIBLE, 1, 0, 0)
        pet:addStatusEffect(tpz.effect.MANAFONT, 1, 0, 0)
        pet:addStatusEffect(tpz.effect.REGAIN, 150, 1, 0)
        pet:addStatusEffect(tpz.effect.REFRESH, 99, 0, 0)
        pet:addStatusEffect(tpz.effect.REGEN, 99, 0, 0)

        -- Add bonus mods to the pet..
        pet:addMod(tpz.mod.RACC, 2500)
        pet:addMod(tpz.mod.RATT, 2500)
        pet:addMod(tpz.mod.ACC, 2500)
        pet:addMod(tpz.mod.ATT, 2500)
        pet:addMod(tpz.mod.MATT, 2500)
        pet:addMod(tpz.mod.MACC, 2500)
        pet:addMod(tpz.mod.RDEF, 2500)
        pet:addMod(tpz.mod.DEF, 2500)
        pet:addMod(tpz.mod.MDEF, 2500)

        -- Heal the pet from the new buffs..
        pet:addHP( 50000 )
        pet:setMP( 50000 )
    else
        -- Toggle GodMode off..
        pet:setLocalVar("GodMode", 0)

        -- Remove bonus effects..
        pet:delStatusEffect(tpz.effect.MAX_HP_BOOST)
        pet:delStatusEffect(tpz.effect.MAX_MP_BOOST)
        pet:delStatusEffect(tpz.effect.SENTINEL)
        pet:delStatusEffect(tpz.effect.MIGHTY_STRIKES)
        pet:delStatusEffect(tpz.effect.HUNDRED_FISTS)
        pet:delStatusEffect(tpz.effect.CHAINSPELL)
        pet:delStatusEffect(tpz.effect.PERFECT_DODGE)
        pet:delStatusEffect(tpz.effect.INVINCIBLE)
        pet:delStatusEffect(tpz.effect.MANAFONT)
        pet:delStatusEffect(tpz.effect.REGAIN)
        pet:delStatusEffect(tpz.effect.REFRESH)
        pet:delStatusEffect(tpz.effect.REGEN)

        -- Remove bonus mods..
        pet:delMod(tpz.mod.RACC, 2500)
        pet:delMod(tpz.mod.RATT, 2500)
        pet:delMod(tpz.mod.ACC, 2500)
        pet:delMod(tpz.mod.ATT, 2500)
        pet:delMod(tpz.mod.MATT, 2500)
        pet:delMod(tpz.mod.MACC, 2500)
        pet:delMod(tpz.mod.RDEF, 2500)
        pet:delMod(tpz.mod.DEF, 2500)
        pet:delMod(tpz.mod.MDEF, 2500)
    end
end
