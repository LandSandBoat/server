-----------------------------------
-- Add some test NPCs to GM_HOME (zone 210)
-----------------------------------
require("modules/module_utils")
-----------------------------------
local m = Module:new("test_npcs_in_gm_home")
m:setEnabled(true)

-- TODO: Fix the order modules are loaded, onInitialize has already been called by now...
-- m:addOverride("xi.zones.GM_Home.Zone.onInitialize", function(zone)
--     super(zone)
-- end)

-- Workaround
if m.enabled then
    local zone = GetZone(210)

    -- Insert NPC into zone
    local npc = zone:insertDynamicEntity({
        objtype = xi.objType.NPC,
        name = "Horro",
        modelId = 2430,
        x = 5.000,
        y = 0.000,
        z = 0.000,
        rotation = 128,
        triggerable = true,
    })

    -- Use the mob object however you like
    utils.unused(npc)

    -- Build a cache entry for the new NPC
    -- TODO: The npcs table is nil here, why?
    xi.zones.GM_Home.npcs = {}
    xi.zones.GM_Home.npcs.Horro = {}

    -- Attach regular event handlers to that cache entry
    xi.zones.GM_Home.npcs.Horro.onTrade = function(player, npc, trade)
    end

    xi.zones.GM_Home.npcs.Horro.onTrigger = function(player, npcArg)
        player:PrintToPlayer("Welcome to GM Home!", 0, npcArg:getName())
    end

    xi.zones.GM_Home.npcs.Horro.onEventUpdate = function(player, csid, option)
    end

    xi.zones.GM_Home.npcs.Horro.onEventFinish = function(player, csid, option)
    end
end

return m
