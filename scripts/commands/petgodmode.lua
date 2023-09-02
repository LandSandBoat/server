-----------------------------------
-- func: petgodmode
-- desc: Toggles god mode on the player's pet, granting them several special abilities.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = ''
}

commandObj.onTrigger = function(player)
    local pet = player:getPet()
    if pet and pet:getLocalVar('GodMode') == 0 then
        -- Toggle GodMode on..
        pet:setLocalVar('GodMode', 1)

        -- Add bonus effects to the pet..
        pet:addStatusEffect(xi.effect.MAX_HP_BOOST, 1000, 0, 0)
        pet:addStatusEffect(xi.effect.MAX_MP_BOOST, 1000, 0, 0)
        pet:addStatusEffect(xi.effect.SENTINEL, 100, 0, 0)
        pet:addStatusEffect(xi.effect.MIGHTY_STRIKES, 1, 0, 0)
        pet:addStatusEffect(xi.effect.HUNDRED_FISTS, 1, 0, 0)
        pet:addStatusEffect(xi.effect.CHAINSPELL, 1, 0, 0)
        pet:addStatusEffect(xi.effect.PERFECT_DODGE, 1, 0, 0)
        pet:addStatusEffect(xi.effect.INVINCIBLE, 1, 0, 0)
        pet:addStatusEffect(xi.effect.MANAFONT, 1, 0, 0)
        pet:addStatusEffect(xi.effect.REGAIN, 150, 1, 0)
        pet:addStatusEffect(xi.effect.REFRESH, 99, 0, 0)
        pet:addStatusEffect(xi.effect.REGEN, 99, 0, 0)

        -- Add bonus mods to the pet..
        pet:addMod(xi.mod.RACC, 2500)
        pet:addMod(xi.mod.RATT, 2500)
        pet:addMod(xi.mod.ACC, 2500)
        pet:addMod(xi.mod.ATT, 2500)
        pet:addMod(xi.mod.MATT, 2500)
        pet:addMod(xi.mod.MACC, 2500)
        pet:addMod(xi.mod.RDEF, 2500)
        pet:addMod(xi.mod.DEF, 2500)
        pet:addMod(xi.mod.MDEF, 2500)

        -- Heal the pet from the new buffs..
        pet:addHP(50000)
        pet:setMP(50000)
    else
        -- Toggle GodMode off..
        pet:setLocalVar('GodMode', 0)

        -- Remove bonus effects..
        pet:delStatusEffect(xi.effect.MAX_HP_BOOST)
        pet:delStatusEffect(xi.effect.MAX_MP_BOOST)
        pet:delStatusEffect(xi.effect.SENTINEL)
        pet:delStatusEffect(xi.effect.MIGHTY_STRIKES)
        pet:delStatusEffect(xi.effect.HUNDRED_FISTS)
        pet:delStatusEffect(xi.effect.CHAINSPELL)
        pet:delStatusEffect(xi.effect.PERFECT_DODGE)
        pet:delStatusEffect(xi.effect.INVINCIBLE)
        pet:delStatusEffect(xi.effect.MANAFONT)
        pet:delStatusEffect(xi.effect.REGAIN)
        pet:delStatusEffect(xi.effect.REFRESH)
        pet:delStatusEffect(xi.effect.REGEN)

        -- Remove bonus mods..
        pet:delMod(xi.mod.RACC, 2500)
        pet:delMod(xi.mod.RATT, 2500)
        pet:delMod(xi.mod.ACC, 2500)
        pet:delMod(xi.mod.ATT, 2500)
        pet:delMod(xi.mod.MATT, 2500)
        pet:delMod(xi.mod.MACC, 2500)
        pet:delMod(xi.mod.RDEF, 2500)
        pet:delMod(xi.mod.DEF, 2500)
        pet:delMod(xi.mod.MDEF, 2500)
    end
end

return commandObj
