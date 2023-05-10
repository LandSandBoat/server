-----------------------------------
-- func: sigil
-- desc: Casts sigil on the player.
-----------------------------------

cmdprops =
{
    permission = 0,
    parameters = "is"
}

function onTrigger(player)
    if player:isCrystalWarrior() then
        player:PrintToPlayer("You cannot use this command as a Crystal Warrior.", xi.msg.channel.SYSTEM_3)
        return
    end

    player:PrintToPlayer("Enjoy sigil!")
    player:delStatusEffectsByFlag(xi.effectFlag.INFLUENCE, true)
    player:addStatusEffect(xi.effect.SIGIL, 0, 0, 15000)
end
