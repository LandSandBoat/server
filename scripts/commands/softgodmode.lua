---------------------------------------------------------------------------------------------------
-- func: SoftGodMode
-- desc: Toggles a toned-down version of godmode that allows the GM to test incoming/outgoing damage
-- without having the full-offensive buffs that normal !godmode gives.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 2,
    parameters = ""
}

function onTrigger(player)
    if (player:getCharVar("SoftGodMode") == 0) then
        -- Toggle GodMode on..
        player:setCharVar("SoftGodMode", 1)

        -- Add bonus effects to the player..
        player:addStatusEffect(xi.effect.MAX_HP_BOOST,200,0,0)
        player:addStatusEffect(xi.effect.REGAIN,50,0,0)
        player:addStatusEffect(xi.effect.REFRESH,999,0,0)
        player:addStatusEffect(xi.effect.REGEN,999,0,0)
        player:addStatusEffect(xi.effect.CHAINSPELL, 1, 0, 0)
        player:addStatusEffect(xi.effect.MANAFONT, 1, 0, 0)


        -- Heal the player from the new buffs..
        player:addHP( 50000 )
        player:setMP( 50000 )
    else
        -- Toggle GodMode off..
        player:setCharVar("SoftGodMode", 0)

        -- Remove bonus effects..
        player:delStatusEffect(xi.effect.MAX_HP_BOOST)
        player:delStatusEffect(xi.effect.REGAIN)
        player:delStatusEffect(xi.effect.REFRESH)
        player:delStatusEffect(xi.effect.REGEN)
        player:delStatusEffect(xi.effect.CHAINSPELL)
        player:delStatusEffect(xi.effect.MANAFONT)

    end
end
