-----------------------------------
-- Era Guild Shared Stocks
-- A module to link guild shops to share stocks
-----------------------------------
require('modules/module_utils')
require('scripts/globals/guild_shops')
-----------------------------------
local m = Module:new('era_guild_shared_stocks')

m:addOverride('xi.zones.Metalworks.npcs.Vicious_Eye.onTrigger', function(player, npc)
    if xi.guildShops.onTrigger(player, npc) then
        player:showText(npc, zones[xi.zone.METALWORKS].text.VICIOUS_EYE_SHOP_DIALOG)
    end
end)

m:addOverride('xi.zones.Northern_San_dOria.npcs.Lucretia.onTrigger', function(player, npc)
    local ID = zones[xi.zone.NORTHERN_SAN_DORIA]

    if xi.guildShops.onTrigger(player, npc) then
        player:showText(npc, ID.text.LUCRETIA_SHOP_DIALOG)
    end
end)

m:addOverride('xi.zones.Mhaura.npcs.Mololo.onTrigger', function(player, npc)
    if xi.guildShops.onTrigger(player, npc) then
        player:showText(npc, zones[xi.zone.MHAURA].text.SMITHING_GUILD)
    end
end)

m:addOverride('xi.zones.Bastok_Markets.npcs.Teerth.onTrigger', function(player, npc)
    if xi.guildShops.onTrigger(player, npc) then
        player:showText(npc, zones[xi.zone.BASTOK_MARKETS].text.TEERTH_SHOP_DIALOG)
    end
end)

m:addOverride('xi.zones.Mhaura.npcs.Celestina.onTrigger', function(player, npc)
    xi.guildShops.onTrigger(player, npc)
end)

m:addOverride('xi.zones.Windurst_Waters.npcs.Chomo_Jinjahl.onTrigger', function(player, npc)
    if xi.guildShops.onTrigger(player, npc) then
        player:showText(npc, zones[xi.zone.WINDURST_WATERS].text.CHOMOJINJAHL_SHOP_DIALOG)
    end
end)

m:addOverride('xi.zones.Southern_San_dOria.npcs.Cletae.onTrigger', function(player, npc)
    local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]

    if xi.guildShops.onTrigger(player, npc) then
        player:showText(npc, ID.text.CLETAE_DIALOG)
    end
end)

m:addOverride('xi.zones.Windurst_Woods.npcs.Meriri.onTrigger', function(player, npc)
    if xi.guildShops.onTrigger(player, npc) then
        player:showText(npc, zones[xi.zone.WINDURST_WOODS].text.MERIRI_DIALOG)
    end
end)

m:addOverride('xi.zones.Bastok_Mines.npcs.Odoba.onTrigger', function(player, npc)
    if xi.guildShops.onTrigger(player, npc) then
        player:showText(npc, zones[xi.zone.BASTOK_MINES].text.ODOBA_SHOP_DIALOG)
    end
end)

m:addOverride('xi.zones.Windurst_Woods.npcs.Retto-Marutto.onTrigger', function(player, npc)
    if xi.guildShops.onTrigger(player, npc) then
        player:showText(npc, zones[xi.zone.WINDURST_WOODS].text.RETTO_MARUTTO_DIALOG)
    end
end)

m:addOverride('xi.zones.Selbina.npcs.Gibol.onTrigger', function(player, npc)
    if xi.guildShops.onTrigger(player, npc) then
        player:showText(npc, zones[xi.zone.SELBINA].text.CLOTHCRAFT_SHOP_DIALOG)
    end
end)

m:addOverride('xi.zones.Northern_San_dOria.npcs.Cauzeriste.onTrigger', function(player, npc)
    local ID = zones[xi.zone.NORTHERN_SAN_DORIA]

    if xi.guildShops.onTrigger(player, npc) then
        player:showText(npc, ID.text.CAUZERISTE_SHOP_DIALOG)
    end
end)

-----------------------------------
-- Neptune's Spire Tenshodo guild vendors
-- Akamafula and Amalasanda were converted to normal shops on retail.
-- This reverts them back to being guild shops, while also keeping the tenshodo membership anti-cheat
-- that was already in place on their files.
-----------------------------------
m:addOverride('xi.zones.Lower_Jeuno.npcs.Akamafula.onTrigger', function(player, npc)
    if not player:hasKeyItem(xi.keyItem.TENSHODO_MEMBERS_CARD) then
        return -- Anti-Cheat.
    end

    if xi.guildShops.onTrigger(player, npc) then
        player:showText(npc, zones[xi.zone.LOWER_JEUNO].text.AKAMAFULA_SHOP_DIALOG)
    end
end)

m:addOverride('xi.zones.Lower_Jeuno.npcs.Amalasanda.onTrigger', function(player, npc)
    if not player:hasKeyItem(xi.keyItem.TENSHODO_MEMBERS_CARD) then
        return -- Anti-Cheat.
    end

    if xi.guildShops.onTrigger(player, npc) then
        player:showText(npc, zones[xi.zone.LOWER_JEUNO].text.AMALASANDA_SHOP_DIALOG)
    end
end)
