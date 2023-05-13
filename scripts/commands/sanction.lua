-----------------------------------
-- func: sanction
-- desc: Casts sanction on the player.
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

    player:PrintToPlayer("Enjoy sanction!")
    player:delStatusEffectsByFlag(xi.effectFlag.INFLUENCE, true)
    player:addStatusEffect(xi.effect.SANCTION, 0, 0, 15000)
end
