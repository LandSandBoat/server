-----------------------------------
-- func: !npc
-- desc: Test dynamic entity before its placed into a module for testing.
-- note: Will spawn after you move from your current position
-----------------------------------

cmdprops =
{
    permission = 4,
    parameters = ""
}

function onTrigger(player)
    local zone = player:getZone()

    local npc = zone:insertDynamicEntity({
        -- NPC or MOB
        objtype = xi.objType.NPC,

        -- The name visible to players
        -- NOTE: Even if you plan on making the name invisible, we're using it internally for lookups
        --     : So populate it with something unique-ish even if you aren't going to use it.
        --     : You can then hide the name with entity:hideName(true)
        -- NOTE: This name CAN include spaces and underscores.
        name = "Test",

        -- You can use regular model ids (See documentation/model_ids.txt, or play around with !costume)
        look = 2430,

        -- You can also use the raw packet look information (as a string), as seen in npc_list and mob_pools
        -- look = "0x0100020500101120003000400050006000700000",

        -- Set the NPC at your current position, can set the position using in-game x, y and z if desired.
        x = player:getXPos(),
        y = player:getYPos(),
        z = player:getZPos(),
        rotation = player:getRotPos(),

        -- onTrade and onTrigger can be hooked up to your dynamic entity,
        -- just like with regular entities. You can also omit these.
        onTrade = function(playerArg, npcArg, trade)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            player:PrintToPlayer("No, thanks!", 0, npcArg:getPacketName())
        end,

        -- The entity will not be "triggerable" unless you populate onTrigger
        onTrigger = function(playerArg, npcArg)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            player:PrintToPlayer("Thank you I am free now!", 0, npcArg:getPacketName())
        end,
    })
    player:PrintToPlayer(string.format("Please move to spawn (%s)", npc:getPacketName()))
end

