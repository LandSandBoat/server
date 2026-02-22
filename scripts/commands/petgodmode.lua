-----------------------------------
-- func: petgodmode
-- desc: Toggles god mode on the player's pet, granting them several special abilities.
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = ''
}

commandObj.onTrigger = function(player)
    local pet = player:getPet()
    if not pet then
        return
    end

    if pet:getLocalVar('GodMode') == 0 then
        -- Toggle GodMode on..
        pet:setLocalVar('GodMode', 1)

        -- Add bonus effects to the pet..
        pet:addStatusEffect(xi.effect.MAX_HP_BOOST, { power = 1000, origin = player })
        pet:addStatusEffect(xi.effect.MAX_MP_BOOST, { power = 1000, origin = player })
        pet:addStatusEffect(xi.effect.SENTINEL, { power = 100, origin = player })
        pet:addStatusEffect(xi.effect.MIGHTY_STRIKES, { power = 1, origin = player })
        pet:addStatusEffect(xi.effect.HUNDRED_FISTS, { power = 1, origin = player })
        pet:addStatusEffect(xi.effect.CHAINSPELL, { power = 1, origin = player })
        pet:addStatusEffect(xi.effect.PERFECT_DODGE, { power = 1, origin = player })
        pet:addStatusEffect(xi.effect.INVINCIBLE, { power = 1, origin = player })
        pet:addStatusEffect(xi.effect.MANAFONT, { power = 1, origin = player })
        pet:addStatusEffect(xi.effect.REGAIN, { power = 150, origin = player, tick = 1 })
        pet:addStatusEffect(xi.effect.REFRESH, { power = 99, origin = player })
        pet:addStatusEffect(xi.effect.REGEN, { power = 99, origin = player })

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
