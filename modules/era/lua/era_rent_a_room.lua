-----------------------------------
-- Adds Rent A Room To NPCs
-----------------------------------
require("scripts/globals/zone")
-----------------------------------
local m = Module:new("era_rent_a_room")
local renterNPCs =
{
    "xi.zones.Northern_San_dOria.npcs.Pulloie",
    "xi.zones.Southern_San_dOria.npcs.Fulchia",
    "xi.zones.Port_San_dOria.npcs.Phersula",
    "xi.zones.Bastok_Mines.npcs.Leonie",
    "xi.zones.Bastok_Markets.npcs.Loulia",
    "xi.zones.Port_Bastok.npcs.Wurteh",
    "xi.zones.Windurst_Woods.npcs.Abby_Jalunshi",
    "xi.zones.Windurst_Waters.npcs.Machitata",
    "xi.zones.Windurst_Walls.npcs.Shinchai-Tocchai",
    "xi.zones.Port_Windurst.npcs.Boronene",
    "xi.zones.Port_Jeuno.npcs.Yurugu-Homurugu",
    "xi.zones.Lower_Jeuno.npcs.Miladi-Nildi",
    "xi.zones.Upper_Jeuno.npcs.Zekobi-Morokobi",
    "xi.zones.RuLude_Gardens.npcs.Perisa-Neburusa",
    -- "xi.zones.Al_Zahbi.npcs.Krujaal", (TOAU)
    -- "xi.zones.Aht_Urhgan_Whitegate.npcs.Zhamwaa", (TOAU)
}

if xi.settings.main.ENABLE_TOAU == 1 then
    table.insert(renterNPCs, "xi.zones.Al_Zahbi.npcs.Krujaal")
    table.insert(renterNPCs, "xi.zones.Aht_Urhgan_Whitegate.npcs.Zhamwaa")
end

for _, npcString in pairs(renterNPCs) do
    m:addOverride(string.format("%s.onTrigger", npcString), function(player, npc)
        xi.moghouse.onTriggerRentARoom(player, npc)
    end)

    m:addOverride(string.format("%s.onEventFinish", npcString), function(player, csid, option)
        xi.moghouse.onEventFinishRentARoom(player, csid, option)
    end)
end

return m
