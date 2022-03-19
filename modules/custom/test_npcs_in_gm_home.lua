-----------------------------------
-- Add some test NPCs to GM_HOME (zone 210)
-----------------------------------
require("modules/module_utils")
require("scripts/zones/GM_Home/Zone")
-----------------------------------
local m = Module:new("test_npcs_in_gm_home")
m:setEnabled(true)

m:addOverride("xi.zones.GM_Home.Zone.onInitialize", function(zone)
    super(zone)

    -- Insert NPC into zone
    local horro = zone:insertDynamicEntity({
        objtype = xi.objType.NPC,
        name = "Horro",
        -- See documentation model_ids.txt, or play around with !costume (remember that the bytes are swapped!)
        modelId = 2430,
        x = 5.000,
        y = 0.000,
        z = 0.000,
        rotation = 128,
        triggerable = true,
    })

    -- Use the mob object however you like
    -- horro:getID() etc.
    utils.unused(horro)

    -- There might not be any NPCs populated for GM_Home,
    -- (see npc_list.sql) so the npcs table might not exist.
    -- We're going to make it now.
    -- This shouldn't be needed for other zones.
    xi.zones.GM_Home.npcs = xi.zones.GM_Home.npcs or {}

    -- Build a cache entry for the new NPC
    xi.zones.GM_Home.npcs.Horro = {}

    -- Attach regular event handlers to that cache entry
    xi.zones.GM_Home.npcs.Horro.onTrade = function(player, npc, trade)
    end

    xi.zones.GM_Home.npcs.Horro.onTrigger = function(player, npc)
        player:PrintToPlayer("Welcome to GM Home!", 0, npc:getName())
    end

    xi.zones.GM_Home.npcs.Horro.onEventUpdate = function(player, csid, option)
    end

    xi.zones.GM_Home.npcs.Horro.onEventFinish = function(player, csid, option)
    end
end)

return m
