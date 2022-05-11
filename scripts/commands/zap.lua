---------------------------------------------------------------------------------------------------
-- func: zap
-- desc: expresses GM anger on cursor target
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = ""
}

function onTrigger(player)
    local victim = player:getCursorTarget()

    if not victim then
        player:PrintToPlayer("Must target a player with cursor! ")
        return
    end

    if not victim:isPC() then
        player:PrintToPlayer("Only works on players, not NPCs and not Monsters. ")
        return
    end

    -- Begin Wrath of the Gods Animation
    victim:injectActionPacket(5, 207, 0, 0, 0)
    victim:injectActionPacket(5, 270, 0, 0, 0)
    -- End Wrath of the Gods Animation
    victim:PrintToPlayer("Some tyrant GM just zapped you. o_O ")
end
