-----------------------------------
-- Add some test NPCs to GM_HOME (zone 210)
-----------------------------------
require('modules/module_utils')
require('scripts/zones/GM_Home/Zone')
-----------------------------------
local m = Module:new('test_npcs_in_gm_home')

m:addOverride('xi.zones.GM_Home.Zone.onInitialize', function(zone)
    -- Call the zone's original function for onInitialize
    super(zone)

    -- Insert NPC into zone
    local horro = zone:insertDynamicEntity({

        -- NPC or MOB
        objtype = xi.objType.NPC,

        -- The name visible to players
        -- NOTE: Even if you plan on making the name invisible, we're using it internally for lookups
        --     : So populate it with something unique-ish even if you aren't going to use it.
        --     : You can then hide the name with entity:hideName(true)
        -- NOTE: This name CAN include spaces and underscores.
        name = 'Horro',

        -- Optional: Define a different name that is visible to players.
        -- 'Horro' (DE_Horro) will still be used internally for lookups.
        -- packetName = 'New Horro',

        -- You can use regular model ids (See documentation/model_ids.txt, or play around with !costume)
        look = 2430,

        -- You can also use the raw packet look information (as a string), as seen in npc_list and mob_pools
        -- look = '0x0100020500101120003000400050006000700000',

        -- Set the position using in-game x, y and z
        x = 5.000,
        y = 0.000,
        z = 0.000,

        -- Rotation is scaled 0-255, with 0 being East
        rotation = 128,

        -- Overriding widescan is only available to NPCs.
        widescan = 1,

        -- onTrade and onTrigger can be hooked up to your dynamic entity,
        -- just like with regular entities. You can also omit these.
        onTrade = function(player, npc, trade)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            player:PrintToPlayer('No, thanks!', 0, npc:getPacketName())
        end,

        -- The entity will not be 'triggerable' unless you populate onTrigger
        onTrigger = function(player, npc)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            player:PrintToPlayer('Welcome to GM Home!', 0, npc:getPacketName())
        end,
    })

    -- Use the mob object however you like
    -- horro:getID() etc.
    -- We're not doing anything with it, so ignore this object
    utils.unused(horro)

    -- You could also just not capture the object
    -- zone:insertDynamicEntity({ ...
end)

return m
