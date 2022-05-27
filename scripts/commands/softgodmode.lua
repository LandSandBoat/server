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
        player:addStatusEffect(tpz.effect.MAX_HP_BOOST,200,0,0)
        player:addStatusEffect(tpz.effect.REGAIN,50,0,0)
        player:addStatusEffect(tpz.effect.REFRESH,999,0,0)
        player:addStatusEffect(tpz.effect.REGEN,999,0,0)
        player:addStatusEffect(tpz.effect.CHAINSPELL, 1, 0, 0)
        player:addStatusEffect(tpz.effect.MANAFONT, 1, 0, 0)


        -- Heal the player from the new buffs..
        player:addHP( 50000 )
        player:setMP( 50000 )
    else
        -- Toggle GodMode off..
        player:setCharVar("SoftGodMode", 0)

        -- Remove bonus effects..
        player:delStatusEffect(tpz.effect.MAX_HP_BOOST)
        player:delStatusEffect(tpz.effect.REGAIN)
        player:delStatusEffect(tpz.effect.REFRESH)
        player:delStatusEffect(tpz.effect.REGEN)
        player:delStatusEffect(tpz.effect.CHAINSPELL)
        player:delStatusEffect(tpz.effect.MANAFONT)

    end
end
