-----------------------------------
-- CatsEyeXI Custom NPCs
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/npc_util")

local m = Module:new("relic_exchange")

m:addOverride("xi.zones.Beaucedine_Glacier.npcs.relic.onTrade", function(player, npc, trade)
    local ID = require("scripts/zones/Beaucedine_Glacier/IDs")

    if (player:getCharVar("RELIC_IN_PROGRESS") == xi.items.VALHALLA and npcUtil.tradeHas(trade, {xi.items.RANPERRE_GOLDPIECE, xi.items.INTRICATE_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.VALHALLA})) then -- currency, shard, necropsyche, stage 4
        player:startEvent(139, xi.items.RAGNAROK)
    end
	
	--  vars for part 1 of the relic exchange program
    local Gil = trade:getGil()
	local ExchangeToken = player:getCharVar("[CXI]RelicExchangeToken")
    local TradeSpharai = npcUtil.tradeHas(trade, xi.items.SPHARAI)
    local TradeMandau = npcUtil.tradeHas(trade, xi.items.MANDAU)
    local TradeExcalibur = npcUtil.tradeHas(trade, xi.items.EXCALIBUR)
    local TradeRagnarok = npcUtil.tradeHas(trade, xi.items.RAGNAROK)
    local TradeGuttler = npcUtil.tradeHas(trade, xi.items.GUTTLER)
    local TradeBravura = npcUtil.tradeHas(trade, xi.items.BRAVURA)
    local TradeApocalypse = npcUtil.tradeHas(trade, xi.items.APOCALYPSE)
    local TradeGungnir = npcUtil.tradeHas(trade, xi.items.GUNGNIR)
    local TradeKikoku = npcUtil.tradeHas(trade, xi.items.KIKOKU)
    local TradeAmano = npcUtil.tradeHas(trade, xi.items.AMANOMURAKUMO)
    local TradeMjollnir = npcUtil.tradeHas(trade, xi.items.MJOLLNIR)
    local TradeClaustrum = npcUtil.tradeHas(trade, xi.items.CLAUSTRUM)
    local TradeYoichi = npcUtil.tradeHas(trade, xi.items.YOICHINOYUMI)
    local TradeAnnihilator = npcUtil.tradeHas(trade, xi.items.ANNIHILATOR)
    local TradeGjallhorn = npcUtil.tradeHas(trade, xi.items.GJALLARHORN)
    local TradeAegis = npcUtil.tradeHas(trade, xi.items.AEGIS)
	
-- vars for part 2	
	local RagnarokExchange = (ExchangeToken == 1 and npcUtil.tradeHas(trade, 15066)) -- relic_shield

-- give player their exchange token
    if Gil == 5000000 and
       (TradeSpharai or TradeMandau or TradeExcalibur or TradeRagnarok or TradeGuttler or TradeBravura or TradeApocalypse or
        TradeGungnir or TradeKikoku or TradeAmano or TradeMjollnir or TradeClaustrum or TradeYoichi or TradeAnnihilator or
        TradeGjallhorn or TradeAegis) then
            player:tradeComplete()
            player:PrintToPlayer("???: You have decided... Now offer me the corresponding vessel and we'll complete the covenant.", 0xD)
            player:setCharVar("[CXI]RelicExchangeToken", 1)
	elseif RagnarokExchange then 
	    player:tradeComplete()
		player:setCharVar("[CXI]RelicExchangeToken", 0)
	    player:addItem(xi.items.RAGNAROK) 
		player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.RAGNAROK)
   	else
        player:PrintToPlayer("???: The covenant states 5,000,000 gil and your existing relic. Don't keep me waiting.", 0xD)
    end
end)

m:addOverride("xi.zones.Beaucedine_Glacier.npcs.relic.onTrigger", function(player, npc)
    player:PrintToPlayer("???: Hail to you hardened traveler,", 0xD)
    player:PrintToPlayer("???: Do you desire to switch your ally? Trade your relic back to me together with 5,000,000 gil", 0xD)
	player:PrintToPlayer("???: and I'll exchange it for my soul. Let me return to the battlefield!", 0xD)
end)

m:addOverride("xi.zones.Carpenters_Landing.npcs.relic.onTrade", function(player, npc, trade)
    local ID = require("scripts/zones/Carpenters_Landing/IDs")
    if (player:getCharVar("RELIC_IN_PROGRESS") == xi.items.ANCILE and npcUtil.tradeHas(trade, {xi.items.RANPERRE_GOLDPIECE, xi.items.SUPERNAL_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.ANCILE})) then -- currency, shard, necropsyche, stage 4
        player:startEvent(44, xi.items.AEGIS)
    end
	
	--  vars for part 1 of the relic exchange program
    local Gil = trade:getGil()
	local ExchangeToken = player:getCharVar("[CXI]RelicExchangeToken")
    local TradeSpharai = npcUtil.tradeHas(trade, xi.items.SPHARAI)
    local TradeMandau = npcUtil.tradeHas(trade, xi.items.MANDAU)
    local TradeExcalibur = npcUtil.tradeHas(trade, xi.items.EXCALIBUR)
    local TradeRagnarok = npcUtil.tradeHas(trade, xi.items.RAGNAROK)
    local TradeGuttler = npcUtil.tradeHas(trade, xi.items.GUTTLER)
    local TradeBravura = npcUtil.tradeHas(trade, xi.items.BRAVURA)
    local TradeApocalypse = npcUtil.tradeHas(trade, xi.items.APOCALYPSE)
    local TradeGungnir = npcUtil.tradeHas(trade, xi.items.GUNGNIR)
    local TradeKikoku = npcUtil.tradeHas(trade, xi.items.KIKOKU)
    local TradeAmano = npcUtil.tradeHas(trade, xi.items.AMANOMURAKUMO)
    local TradeMjollnir = npcUtil.tradeHas(trade, xi.items.MJOLLNIR)
    local TradeClaustrum = npcUtil.tradeHas(trade, xi.items.CLAUSTRUM)
    local TradeYoichi = npcUtil.tradeHas(trade, xi.items.YOICHINOYUMI)
    local TradeAnnihilator = npcUtil.tradeHas(trade, xi.items.ANNIHILATOR)
    local TradeGjallhorn = npcUtil.tradeHas(trade, xi.items.GJALLARHORN)
    local TradeAegis = npcUtil.tradeHas(trade, xi.items.AEGIS)
	
-- vars for part 2	
	local AegisExchange = (ExchangeToken == 1 and npcUtil.tradeHas(trade, 15066)) -- relic_shield

-- give player their exchange token
    if Gil == 5000000 and
       (TradeSpharai or TradeMandau or TradeExcalibur or TradeRagnarok or TradeGuttler or TradeBravura or TradeApocalypse or
        TradeGungnir or TradeKikoku or TradeAmano or TradeMjollnir or TradeClaustrum or TradeYoichi or TradeAnnihilator or
        TradeGjallhorn or TradeAegis) then
            player:tradeComplete()
            player:PrintToPlayer("???: You have decided... Now offer me the corresponding vessel and we'll complete the covenant.", 0xD)
            player:setCharVar("[CXI]RelicExchangeToken", 1)
	elseif AegisExchange then 
	    player:tradeComplete()
		player:setCharVar("[CXI]RelicExchangeToken", 0)
	    player:addItem(xi.items.AEGIS) 
		player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.AEGIS)
   	else
        player:PrintToPlayer("???: The covenant states 5,000,000 gil and your existing relic. Don't keep me waiting.", 0xD)
    end
end)

m:addOverride("xi.zones.Carpenters_Landing.npcs.relic.onTrigger", function(player, npc)
    player:PrintToPlayer("???: Hail to you hardened traveler,", 0xD)
    player:PrintToPlayer("???: Do you desire to switch your ally? Trade your relic back to me together with 5,000,000 gil", 0xD)
	player:PrintToPlayer("???: and I'll exchange it for my soul. Let me return to the battlefield!", 0xD)
end)

m:addOverride("xi.zones.Castle_Oztroja.npcs.relic.onTrade", function(player, npc, trade)
    local ID = require("scripts/zones/Castle_Oztroja/IDs")
    if (player:getCharVar("RELIC_IN_PROGRESS") == xi.items.CAESTUS and npcUtil.tradeHas(trade, {xi.items.TEN_THOUSAND_BYNE_BILL, xi.items.MYSTIC_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.CAESTUS})) then -- currency, shard, necropsyche, stage 4
        player:startEvent(59, xi.items.SPHARAI)
    end
		
--  vars for part 1 of the relic exchange program
    local Gil = trade:getGil()
	local ExchangeToken = player:getCharVar("[CXI]RelicExchangeToken")
    local TradeSpharai = npcUtil.tradeHas(trade, xi.items.SPHARAI)
    local TradeMandau = npcUtil.tradeHas(trade, xi.items.MANDAU)
    local TradeExcalibur = npcUtil.tradeHas(trade, xi.items.EXCALIBUR)
    local TradeRagnarok = npcUtil.tradeHas(trade, xi.items.RAGNAROK)
    local TradeGuttler = npcUtil.tradeHas(trade, xi.items.GUTTLER)
    local TradeBravura = npcUtil.tradeHas(trade, xi.items.BRAVURA)
    local TradeApocalypse = npcUtil.tradeHas(trade, xi.items.APOCALYPSE)
    local TradeGungnir = npcUtil.tradeHas(trade, xi.items.GUNGNIR)
    local TradeKikoku = npcUtil.tradeHas(trade, xi.items.KIKOKU)
    local TradeAmano = npcUtil.tradeHas(trade, xi.items.AMANOMURAKUMO)
    local TradeMjollnir = npcUtil.tradeHas(trade, xi.items.MJOLLNIR)
    local TradeClaustrum = npcUtil.tradeHas(trade, xi.items.CLAUSTRUM)
    local TradeYoichi = npcUtil.tradeHas(trade, xi.items.YOICHINOYUMI)
    local TradeAnnihilator = npcUtil.tradeHas(trade, xi.items.ANNIHILATOR)
    local TradeGjallhorn = npcUtil.tradeHas(trade, xi.items.GJALLARHORN)
    local TradeAegis = npcUtil.tradeHas(trade, xi.items.AEGIS)
	
-- vars for part 2	
	local SpharaiExchange = (ExchangeToken == 1 and npcUtil.tradeHas(trade, 18260)) -- relic_knuckles

-- give player their exchange token
    if Gil == 5000000 and
       (TradeSpharai or TradeMandau or TradeExcalibur or TradeRagnarok or TradeGuttler or TradeBravura or TradeApocalypse or
        TradeGungnir or TradeKikoku or TradeAmano or TradeMjollnir or TradeClaustrum or TradeYoichi or TradeAnnihilator or
        TradeGjallhorn or TradeAegis) then
            player:tradeComplete()
            player:PrintToPlayer("???: You have decided... Now offer me the corresponding vessel and we'll complete the covenant.", 0xD)
            player:setCharVar("[CXI]RelicExchangeToken", 1)
    elseif SpharaiExchange then 
		player:tradeComplete()
		player:setCharVar("[CXI]RelicExchangeToken", 0)
	    player:addItem(xi.items.SPHARAI)
		player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.SPHARAI)
   	else
        player:PrintToPlayer("???: The covenant states 5,000,000 gil and your existing relic. Don't keep me waiting.", 0xD)
    end
end)

m:addOverride("xi.zones.Castle_Oztroja.npcs.relic.onTrigger", function(player, npc)
    player:PrintToPlayer("???: Hail to you hardened traveler,", 0xD)
    player:PrintToPlayer("???: Do you desire to switch your ally? Trade your relic back to me together with 5,000,000 gil", 0xD)
	player:PrintToPlayer("???: and I'll exchange it for my soul. Let me return to the battlefield!", 0xD)
end)

m:addOverride("xi.zones.Dragons_Aery.npcs.relic.onTrade", function(player, npc, trade)
    local ID = require("scripts/zones/Dragons_Aery/IDs")
    if (player:getCharVar("RELIC_IN_PROGRESS") == xi.items.CALIBURN and npcUtil.tradeHas(trade, {xi.items.RANPERRE_GOLDPIECE, xi.items.HOLY_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.CALIBURN})) then -- currency, shard, necropsyche, stage 4
        player:startEvent(3, xi.items.EXCALIBUR)
	end
	
	--  vars for part 1 of the relic exchange program
    local Gil = trade:getGil()
	local ExchangeToken = player:getCharVar("[CXI]RelicExchangeToken")
    local TradeSpharai = npcUtil.tradeHas(trade, xi.items.SPHARAI)
    local TradeMandau = npcUtil.tradeHas(trade, xi.items.MANDAU)
    local TradeExcalibur = npcUtil.tradeHas(trade, xi.items.EXCALIBUR)
    local TradeRagnarok = npcUtil.tradeHas(trade, xi.items.RAGNAROK)
    local TradeGuttler = npcUtil.tradeHas(trade, xi.items.GUTTLER)
    local TradeBravura = npcUtil.tradeHas(trade, xi.items.BRAVURA)
    local TradeApocalypse = npcUtil.tradeHas(trade, xi.items.APOCALYPSE)
    local TradeGungnir = npcUtil.tradeHas(trade, xi.items.GUNGNIR)
    local TradeKikoku = npcUtil.tradeHas(trade, xi.items.KIKOKU)
    local TradeAmano = npcUtil.tradeHas(trade, xi.items.AMANOMURAKUMO)
    local TradeMjollnir = npcUtil.tradeHas(trade, xi.items.MJOLLNIR)
    local TradeClaustrum = npcUtil.tradeHas(trade, xi.items.CLAUSTRUM)
    local TradeYoichi = npcUtil.tradeHas(trade, xi.items.YOICHINOYUMI)
    local TradeAnnihilator = npcUtil.tradeHas(trade, xi.items.ANNIHILATOR)
    local TradeGjallhorn = npcUtil.tradeHas(trade, xi.items.GJALLARHORN)
    local TradeAegis = npcUtil.tradeHas(trade, xi.items.AEGIS)
	
-- vars for part 2	
	local ExcaliburExchange = (ExchangeToken == 1 and npcUtil.tradeHas(trade, 18272)) -- relic_sword

-- give player their exchange token
    if Gil == 5000000 and
       (TradeSpharai or TradeMandau or TradeExcalibur or TradeRagnarok or TradeGuttler or TradeBravura or TradeApocalypse or
        TradeGungnir or TradeKikoku or TradeAmano or TradeMjollnir or TradeClaustrum or TradeYoichi or TradeAnnihilator or
        TradeGjallhorn or TradeAegis) then
            player:tradeComplete()
            player:PrintToPlayer("???: You have decided... Now offer me the corresponding vessel and we'll complete the covenant.", 0xD)
            player:setCharVar("[CXI]RelicExchangeToken", 1)
	elseif ExcaliburExchange then 
	    player:tradeComplete()
		player:setCharVar("[CXI]RelicExchangeToken", 0)
	    player:addItem(xi.items.EXCALIBUR)
		player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.EXCALIBUR)
   	else
        player:PrintToPlayer("???: The covenant states 5,000,000 gil and your existing relic. Don't keep me waiting.", 0xD)
    end

end)

m:addOverride("xi.zones.Dragons_Aery.npcs.relic.onTrigger", function(player, npc)
    player:PrintToPlayer("???: Hail to you hardened traveler,", 0xD)
    player:PrintToPlayer("???: Do you desire to switch your ally? Trade your relic back to me together with 5,000,000 gil", 0xD)
	player:PrintToPlayer("???: and I'll exchange it for my soul. Let me return to the battlefield!", 0xD)
end)

m:addOverride("xi.zones.Horlais_Peak.npcs.relic.onTrade", function(player, npc, trade)
    local ID = require("scripts/zones/Horlais_Peak/IDs")
    if (player:getCharVar("RELIC_IN_PROGRESS") == xi.items.TOTSUKANOTSURUGI and npcUtil.tradeHas(trade, {xi.items.RANPERRE_GOLDPIECE, xi.items.DIVINE_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.TOTSUKANOTSURUGI})) then -- currency, shard, necropsyche, stage 4
        player:startEvent(13, xi.items.AMANOMURAKUMO)
    end
	
	--  vars for part 1 of the relic exchange program
    local Gil = trade:getGil()
	local ExchangeToken = player:getCharVar("[CXI]RelicExchangeToken")
    local TradeSpharai = npcUtil.tradeHas(trade, xi.items.SPHARAI)
    local TradeMandau = npcUtil.tradeHas(trade, xi.items.MANDAU)
    local TradeExcalibur = npcUtil.tradeHas(trade, xi.items.EXCALIBUR)
    local TradeRagnarok = npcUtil.tradeHas(trade, xi.items.RAGNAROK)
    local TradeGuttler = npcUtil.tradeHas(trade, xi.items.GUTTLER)
    local TradeBravura = npcUtil.tradeHas(trade, xi.items.BRAVURA)
    local TradeApocalypse = npcUtil.tradeHas(trade, xi.items.APOCALYPSE)
    local TradeGungnir = npcUtil.tradeHas(trade, xi.items.GUNGNIR)
    local TradeKikoku = npcUtil.tradeHas(trade, xi.items.KIKOKU)
    local TradeAmano = npcUtil.tradeHas(trade, xi.items.AMANOMURAKUMO)
    local TradeMjollnir = npcUtil.tradeHas(trade, xi.items.MJOLLNIR)
    local TradeClaustrum = npcUtil.tradeHas(trade, xi.items.CLAUSTRUM)
    local TradeYoichi = npcUtil.tradeHas(trade, xi.items.YOICHINOYUMI)
    local TradeAnnihilator = npcUtil.tradeHas(trade, xi.items.ANNIHILATOR)
    local TradeGjallhorn = npcUtil.tradeHas(trade, xi.items.GJALLARHORN)
    local TradeAegis = npcUtil.tradeHas(trade, xi.items.AEGIS)
	
-- vars for part 2	
	local AmanoExchange = (ExchangeToken == 1 and npcUtil.tradeHas(trade, 18314)) -- ito

-- give player their exchange token
    if Gil == 5000000 and
       (TradeSpharai or TradeMandau or TradeExcalibur or TradeRagnarok or TradeGuttler or TradeBravura or TradeApocalypse or
        TradeGungnir or TradeKikoku or TradeAmano or TradeMjollnir or TradeClaustrum or TradeYoichi or TradeAnnihilator or
        TradeGjallhorn or TradeAegis) then
            player:tradeComplete()
            player:PrintToPlayer("???: You have decided... Now offer me the corresponding vessel and we'll complete the covenant.", 0xD)
            player:setCharVar("[CXI]RelicExchangeToken", 1)
	elseif AmanoExchange then 
	    player:tradeComplete()
		player:setCharVar("[CXI]RelicExchangeToken", 0)
	    player:addItem(xi.items.AMANOMURAKUMO) 
		player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.AMANOMURAKUMO)
   	else
        player:PrintToPlayer("???: The covenant states 5,000,000 gil and your existing relic. Don't keep me waiting.", 0xD)
    end
end)

m:addOverride("xi.zones.Horlais_Peak.npcs.relic.onTrigger", function(player, npc)
    player:PrintToPlayer("???: Hail to you hardened traveler,", 0xD)
    player:PrintToPlayer("???: Do you desire to switch your ally? Trade your relic back to me together with 5,000,000 gil", 0xD)
	player:PrintToPlayer("???: and I'll exchange it for my soul. Let me return to the battlefield!", 0xD)
end)

m:addOverride("xi.zones.Ifrits_Cauldron.npcs.relic.onTrade", function(player, npc, trade)
    local ID = require("scripts/zones/Ifrits_Cauldron/IDs")
    if
        player:getCharVar("RELIC_IN_PROGRESS") == xi.items.THYRUS and
        npcUtil.tradeHas(trade, {xi.items.RIMILALA_STRIPESHELL, xi.items.CELESTIAL_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.THYRUS}) -- currency, shard, necropsyche, stage 4
    then
        player:startEvent(32, xi.items.CLAUSTRUM)
    end
	
	--  vars for part 1 of the relic exchange program
    local Gil = trade:getGil()
	local ExchangeToken = player:getCharVar("[CXI]RelicExchangeToken")
    local TradeSpharai = npcUtil.tradeHas(trade, xi.items.SPHARAI)
    local TradeMandau = npcUtil.tradeHas(trade, xi.items.MANDAU)
    local TradeExcalibur = npcUtil.tradeHas(trade, xi.items.EXCALIBUR)
    local TradeRagnarok = npcUtil.tradeHas(trade, xi.items.RAGNAROK)
    local TradeGuttler = npcUtil.tradeHas(trade, xi.items.GUTTLER)
    local TradeBravura = npcUtil.tradeHas(trade, xi.items.BRAVURA)
    local TradeApocalypse = npcUtil.tradeHas(trade, xi.items.APOCALYPSE)
    local TradeGungnir = npcUtil.tradeHas(trade, xi.items.GUNGNIR)
    local TradeKikoku = npcUtil.tradeHas(trade, xi.items.KIKOKU)
    local TradeAmano = npcUtil.tradeHas(trade, xi.items.AMANOMURAKUMO)
    local TradeMjollnir = npcUtil.tradeHas(trade, xi.items.MJOLLNIR)
    local TradeClaustrum = npcUtil.tradeHas(trade, xi.items.CLAUSTRUM)
    local TradeYoichi = npcUtil.tradeHas(trade, xi.items.YOICHINOYUMI)
    local TradeAnnihilator = npcUtil.tradeHas(trade, xi.items.ANNIHILATOR)
    local TradeGjallhorn = npcUtil.tradeHas(trade, xi.items.GJALLARHORN)
    local TradeAegis = npcUtil.tradeHas(trade, xi.items.AEGIS)
	
-- vars for part 2	
	local ClaustrumExchange = (ExchangeToken == 1 and npcUtil.tradeHas(trade, 18326)) -- relic_staff

-- give player their exchange token
    if Gil == 5000000 and
       (TradeSpharai or TradeMandau or TradeExcalibur or TradeRagnarok or TradeGuttler or TradeBravura or TradeApocalypse or
        TradeGungnir or TradeKikoku or TradeAmano or TradeMjollnir or TradeClaustrum or TradeYoichi or TradeAnnihilator or
        TradeGjallhorn or TradeAegis) then
            player:tradeComplete()
            player:PrintToPlayer("???: You have decided... Now offer me the corresponding vessel and we'll complete the covenant.", 0xD)
            player:setCharVar("[CXI]RelicExchangeToken", 1)
	elseif ClaustrumExchange then 
	    player:tradeComplete()
		player:setCharVar("[CXI]RelicExchangeToken", 0)
	    player:addItem(xi.items.CLAUSTRUM) 
		player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.CLAUSTRUM)
   	else
        player:PrintToPlayer("???: The covenant states 5,000,000 gil and your existing relic. Don't keep me waiting.", 0xD)
    end
end)

m:addOverride("xi.zones.Ifrits_Cauldron.npcs.relic.onTrigger", function(player, npc)
    player:PrintToPlayer("???: Hail to you hardened traveler,", 0xD)
    player:PrintToPlayer("???: Do you desire to switch your ally? Trade your relic back to me together with 5,000,000 gil", 0xD)
	player:PrintToPlayer("???: and I'll exchange it for my soul. Let me return to the battlefield!", 0xD)
end)

m:addOverride("xi.zones.Metalworks.npcs.relic.onTrade", function(player, npc, trade)
    local ID = require("scripts/zones/Metalworks/IDs")
    if (player:getCharVar("RELIC_IN_PROGRESS") == xi.items.FERDINAND and npcUtil.tradeHas(trade, {xi.items.TEN_THOUSAND_BYNE_BILL, xi.items.ETHEREAL_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.FERDINAND})) then -- currency, shard, necropsyche, stage 4
        player:startEvent(843, xi.items.ANNIHILATOR)
    end
	
	--  vars for part 1 of the relic exchange program
    local Gil = trade:getGil()
	local ExchangeToken = player:getCharVar("[CXI]RelicExchangeToken")
    local TradeSpharai = npcUtil.tradeHas(trade, xi.items.SPHARAI)
    local TradeMandau = npcUtil.tradeHas(trade, xi.items.MANDAU)
    local TradeExcalibur = npcUtil.tradeHas(trade, xi.items.EXCALIBUR)
    local TradeRagnarok = npcUtil.tradeHas(trade, xi.items.RAGNAROK)
    local TradeGuttler = npcUtil.tradeHas(trade, xi.items.GUTTLER)
    local TradeBravura = npcUtil.tradeHas(trade, xi.items.BRAVURA)
    local TradeApocalypse = npcUtil.tradeHas(trade, xi.items.APOCALYPSE)
    local TradeGungnir = npcUtil.tradeHas(trade, xi.items.GUNGNIR)
    local TradeKikoku = npcUtil.tradeHas(trade, xi.items.KIKOKU)
    local TradeAmano = npcUtil.tradeHas(trade, xi.items.AMANOMURAKUMO)
    local TradeMjollnir = npcUtil.tradeHas(trade, xi.items.MJOLLNIR)
    local TradeClaustrum = npcUtil.tradeHas(trade, xi.items.CLAUSTRUM)
    local TradeYoichi = npcUtil.tradeHas(trade, xi.items.YOICHINOYUMI)
    local TradeAnnihilator = npcUtil.tradeHas(trade, xi.items.ANNIHILATOR)
    local TradeGjallhorn = npcUtil.tradeHas(trade, xi.items.GJALLARHORN)
    local TradeAegis = npcUtil.tradeHas(trade, xi.items.AEGIS)
	
-- vars for part 2	
	local AnnihilatorExchange = (ExchangeToken == 1 and npcUtil.tradeHas(trade, 18332)) -- relic_gun

-- give player their exchange token
    if Gil == 5000000 and
       (TradeSpharai or TradeMandau or TradeExcalibur or TradeRagnarok or TradeGuttler or TradeBravura or TradeApocalypse or
        TradeGungnir or TradeKikoku or TradeAmano or TradeMjollnir or TradeClaustrum or TradeYoichi or TradeAnnihilator or
        TradeGjallhorn or TradeAegis) then
            player:tradeComplete()
            player:PrintToPlayer("???: You have decided... Now offer me the corresponding vessel and we'll complete the covenant.", 0xD)
            player:setCharVar("[CXI]RelicExchangeToken", 1)
	elseif AnnihilatorExchange then 
	    player:tradeComplete()
		player:setCharVar("[CXI]RelicExchangeToken", 0)
	    player:addItem(xi.items.ANNIHILATOR)
		player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.ANNIHILATOR)
   	else
        player:PrintToPlayer("???: The covenant states 5,000,000 gil and your existing relic. Don't keep me waiting.", 0xD)
    end
end)

m:addOverride("xi.zones.Metalworks.npcs.relic.onTrigger", function(player, npc)
    player:PrintToPlayer("???: Hail to you hardened traveler,", 0xD)
    player:PrintToPlayer("???: Do you desire to switch your ally? Trade your relic back to me together with 5,000,000 gil", 0xD)
	player:PrintToPlayer("???: and I'll exchange it for my soul. Let me return to the battlefield!", 0xD)
end)

m:addOverride("xi.zones.North_Gustaberg.npcs.relic.onTrade", function(player, npc, trade)
    local ID = require("scripts/zones/North_Gustaberg/IDs")
    if player:getCharVar("RELIC_IN_PROGRESS") == xi.items.BEC_DE_FAUCON and npcUtil.tradeHas(trade, {xi.items.RIMILALA_STRIPESHELL, xi.items.TENEBROUS_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.BEC_DE_FAUCON}) then -- currency, shard, necropsyche, stage 4
        player:startEvent(254, xi.items.APOCALYPSE)
    end
	
	--  vars for part 1 of the relic exchange program
    local Gil = trade:getGil()
	local ExchangeToken = player:getCharVar("[CXI]RelicExchangeToken")
    local TradeSpharai = npcUtil.tradeHas(trade, xi.items.SPHARAI)
    local TradeMandau = npcUtil.tradeHas(trade, xi.items.MANDAU)
    local TradeExcalibur = npcUtil.tradeHas(trade, xi.items.EXCALIBUR)
    local TradeRagnarok = npcUtil.tradeHas(trade, xi.items.RAGNAROK)
    local TradeGuttler = npcUtil.tradeHas(trade, xi.items.GUTTLER)
    local TradeBravura = npcUtil.tradeHas(trade, xi.items.BRAVURA)
    local TradeApocalypse = npcUtil.tradeHas(trade, xi.items.APOCALYPSE)
    local TradeGungnir = npcUtil.tradeHas(trade, xi.items.GUNGNIR)
    local TradeKikoku = npcUtil.tradeHas(trade, xi.items.KIKOKU)
    local TradeAmano = npcUtil.tradeHas(trade, xi.items.AMANOMURAKUMO)
    local TradeMjollnir = npcUtil.tradeHas(trade, xi.items.MJOLLNIR)
    local TradeClaustrum = npcUtil.tradeHas(trade, xi.items.CLAUSTRUM)
    local TradeYoichi = npcUtil.tradeHas(trade, xi.items.YOICHINOYUMI)
    local TradeAnnihilator = npcUtil.tradeHas(trade, xi.items.ANNIHILATOR)
    local TradeGjallhorn = npcUtil.tradeHas(trade, xi.items.GJALLARHORN)
    local TradeAegis = npcUtil.tradeHas(trade, xi.items.AEGIS)
	
-- vars for part 2	
	local ApocalypseExchange = (ExchangeToken == 1 and npcUtil.tradeHas(trade, 18302)) -- relic_scythe

-- give player their exchange token
    if Gil == 5000000 and
       (TradeSpharai or TradeMandau or TradeExcalibur or TradeRagnarok or TradeGuttler or TradeBravura or TradeApocalypse or
        TradeGungnir or TradeKikoku or TradeAmano or TradeMjollnir or TradeClaustrum or TradeYoichi or TradeAnnihilator or
        TradeGjallhorn or TradeAegis) then
            player:tradeComplete()
            player:PrintToPlayer("???: You have decided... Now offer me the corresponding vessel and we'll complete the covenant.", 0xD)
            player:setCharVar("[CXI]RelicExchangeToken", 1)
	elseif ApocalypseExchange then 
	    player:tradeComplete()
		player:setCharVar("[CXI]RelicExchangeToken", 0)
	    player:addItem(xi.items.APOCALYPSE) 
		player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.APOCALYPSE)
   	else
        player:PrintToPlayer("???: The covenant states 5,000,000 gil and your existing relic. Don't keep me waiting.", 0xD)
    end
end)

m:addOverride("xi.zones.North_Gustaberg.npcs.relic.onTrigger", function(player, npc)
    player:PrintToPlayer("???: Hail to you hardened traveler,", 0xD)
    player:PrintToPlayer("???: Do you desire to switch your ally? Trade your relic back to me together with 5,000,000 gil", 0xD)
	player:PrintToPlayer("???: and I'll exchange it for my soul. Let me return to the battlefield!", 0xD)
end)

m:addOverride("xi.zones.RuAun_Gardens.npcs.relic.onTrade", function(player, npc, trade)
    local ID = require("scripts/zones/RuAun_Gardens/IDs")
    if
        player:getCharVar("RELIC_IN_PROGRESS") == xi.items.GAE_ASSAIL and
        npcUtil.tradeHasExactly(trade, {xi.items.RIMILALA_STRIPESHELL, xi.items.STELLAR_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.GAE_ASSAIL})
    then -- currency, shard, necropsyche, stage 4
        player:startEvent(60, xi.items.GUNGNIR)
    end
	
	--  vars for part 1 of the relic exchange program
    local Gil = trade:getGil()
	local ExchangeToken = player:getCharVar("[CXI]RelicExchangeToken")
    local TradeSpharai = npcUtil.tradeHas(trade, xi.items.SPHARAI)
    local TradeMandau = npcUtil.tradeHas(trade, xi.items.MANDAU)
    local TradeExcalibur = npcUtil.tradeHas(trade, xi.items.EXCALIBUR)
    local TradeRagnarok = npcUtil.tradeHas(trade, xi.items.RAGNAROK)
    local TradeGuttler = npcUtil.tradeHas(trade, xi.items.GUTTLER)
    local TradeBravura = npcUtil.tradeHas(trade, xi.items.BRAVURA)
    local TradeApocalypse = npcUtil.tradeHas(trade, xi.items.APOCALYPSE)
    local TradeGungnir = npcUtil.tradeHas(trade, xi.items.GUNGNIR)
    local TradeKikoku = npcUtil.tradeHas(trade, xi.items.KIKOKU)
    local TradeAmano = npcUtil.tradeHas(trade, xi.items.AMANOMURAKUMO)
    local TradeMjollnir = npcUtil.tradeHas(trade, xi.items.MJOLLNIR)
    local TradeClaustrum = npcUtil.tradeHas(trade, xi.items.CLAUSTRUM)
    local TradeYoichi = npcUtil.tradeHas(trade, xi.items.YOICHINOYUMI)
    local TradeAnnihilator = npcUtil.tradeHas(trade, xi.items.ANNIHILATOR)
    local TradeGjallhorn = npcUtil.tradeHas(trade, xi.items.GJALLARHORN)
    local TradeAegis = npcUtil.tradeHas(trade, xi.items.AEGIS)
	
-- vars for part 2	
	local GungnirExchange = (ExchangeToken == 1 and npcUtil.tradeHas(trade, 18296)) -- relic_lance

-- give player their exchange token
    if Gil == 5000000 and
       (TradeSpharai or TradeMandau or TradeExcalibur or TradeRagnarok or TradeGuttler or TradeBravura or TradeApocalypse or
        TradeGungnir or TradeKikoku or TradeAmano or TradeMjollnir or TradeClaustrum or TradeYoichi or TradeAnnihilator or
        TradeGjallhorn or TradeAegis) then
            player:tradeComplete()
            player:PrintToPlayer("???: You have decided... Now offer me the corresponding vessel and we'll complete the covenant.", 0xD)
            player:setCharVar("[CXI]RelicExchangeToken", 1)
	elseif GungnirExchange then 
	    player:tradeComplete()
		player:setCharVar("[CXI]RelicExchangeToken", 0)
	    player:addItem(xi.items.GUNGNIR) 
		player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.GUNGNIR)
   	else
        player:PrintToPlayer("???: The covenant states 5,000,000 gil and your existing relic. Don't keep me waiting.", 0xD)
    end
end)

m:addOverride("xi.zones.RuAun_Gardens.npcs.relic.onTrigger", function(player, npc)
    player:PrintToPlayer("???: Hail to you hardened traveler,", 0xD)
    player:PrintToPlayer("???: Do you desire to switch your ally? Trade your relic back to me together with 5,000,000 gil", 0xD)
	player:PrintToPlayer("???: and I'll exchange it for my soul. Let me return to the battlefield!", 0xD)
end)

m:addOverride("xi.zones.RuLude_Gardens.npcs.relic.onTrade", function(player, npc, trade)
    local ID = require("scripts/zones/RuLude_Gardens/IDs")
    if
        player:getCharVar("RELIC_IN_PROGRESS") == xi.items.ABADDON_KILLER and
        npcUtil.tradeHas(trade, {xi.items.TEN_THOUSAND_BYNE_BILL, xi.items.SERAPHIC_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.ABADDON_KILLER})
    then -- currency, shard, necropsyche, stage 4
        player:startEvent(10035, xi.items.BRAVURA)
    end
	
	--  vars for part 1 of the relic exchange program
    local Gil = trade:getGil()
	local ExchangeToken = player:getCharVar("[CXI]RelicExchangeToken")
    local TradeSpharai = npcUtil.tradeHas(trade, xi.items.SPHARAI)
    local TradeMandau = npcUtil.tradeHas(trade, xi.items.MANDAU)
    local TradeExcalibur = npcUtil.tradeHas(trade, xi.items.EXCALIBUR)
    local TradeRagnarok = npcUtil.tradeHas(trade, xi.items.RAGNAROK)
    local TradeGuttler = npcUtil.tradeHas(trade, xi.items.GUTTLER)
    local TradeBravura = npcUtil.tradeHas(trade, xi.items.BRAVURA)
    local TradeApocalypse = npcUtil.tradeHas(trade, xi.items.APOCALYPSE)
    local TradeGungnir = npcUtil.tradeHas(trade, xi.items.GUNGNIR)
    local TradeKikoku = npcUtil.tradeHas(trade, xi.items.KIKOKU)
    local TradeAmano = npcUtil.tradeHas(trade, xi.items.AMANOMURAKUMO)
    local TradeMjollnir = npcUtil.tradeHas(trade, xi.items.MJOLLNIR)
    local TradeClaustrum = npcUtil.tradeHas(trade, xi.items.CLAUSTRUM)
    local TradeYoichi = npcUtil.tradeHas(trade, xi.items.YOICHINOYUMI)
    local TradeAnnihilator = npcUtil.tradeHas(trade, xi.items.ANNIHILATOR)
    local TradeGjallhorn = npcUtil.tradeHas(trade, xi.items.GJALLARHORN)
    local TradeAegis = npcUtil.tradeHas(trade, xi.items.AEGIS)
	
-- vars for part 2	
	local BravuraExchange = (ExchangeToken == 1 and npcUtil.tradeHas(trade, 18290)) -- relic_bhuj

-- give player their exchange token
    if Gil == 5000000 and
       (TradeSpharai or TradeMandau or TradeExcalibur or TradeRagnarok or TradeGuttler or TradeBravura or TradeApocalypse or
        TradeGungnir or TradeKikoku or TradeAmano or TradeMjollnir or TradeClaustrum or TradeYoichi or TradeAnnihilator or
        TradeGjallhorn or TradeAegis) then
            player:tradeComplete()
            player:PrintToPlayer("???: You have decided... Now offer me the corresponding vessel and we'll complete the covenant.", 0xD)
            player:setCharVar("[CXI]RelicExchangeToken", 1)
	elseif BravuraExchange then 
	    player:tradeComplete()
		player:setCharVar("[CXI]RelicExchangeToken", 0)
	    player:addItem(xi.items.BRAVURA) 
		player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.BRAVURA)
   	else
        player:PrintToPlayer("???: The covenant states 5,000,000 gil and your existing relic. Don't keep me waiting.", 0xD)
    end
end)

m:addOverride("xi.zones.RuLude_Gardens.npcs.relic.onTrigger", function(player, npc)
    player:PrintToPlayer("???: Hail to you hardened traveler,", 0xD)
    player:PrintToPlayer("???: Do you desire to switch your ally? Trade your relic back to me together with 5,000,000 gil", 0xD)
	player:PrintToPlayer("???: and I'll exchange it for my soul. Let me return to the battlefield!", 0xD)
end)

m:addOverride("xi.zones.Sea_Serpent_Grotto.npcs.relic.onTrade", function(player, npc, trade)
    local ID = require("scripts/zones/Sea_Serpent_Grotto/IDs")
    if player:getCharVar("RELIC_IN_PROGRESS") == xi.items.YOSHIMITSU and npcUtil.tradeHas(trade, {xi.items.TEN_THOUSAND_BYNE_BILL, xi.items.DEMONIAC_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.YOSHIMITSU}) then -- currency, shard, necropsyche, stage 4
        player:startEvent(11, xi.items.KIKOKU)
    end
	
	--  vars for part 1 of the relic exchange program
    local Gil = trade:getGil()
	local ExchangeToken = player:getCharVar("[CXI]RelicExchangeToken")
    local TradeSpharai = npcUtil.tradeHas(trade, xi.items.SPHARAI)
    local TradeMandau = npcUtil.tradeHas(trade, xi.items.MANDAU)
    local TradeExcalibur = npcUtil.tradeHas(trade, xi.items.EXCALIBUR)
    local TradeRagnarok = npcUtil.tradeHas(trade, xi.items.RAGNAROK)
    local TradeGuttler = npcUtil.tradeHas(trade, xi.items.GUTTLER)
    local TradeBravura = npcUtil.tradeHas(trade, xi.items.BRAVURA)
    local TradeApocalypse = npcUtil.tradeHas(trade, xi.items.APOCALYPSE)
    local TradeGungnir = npcUtil.tradeHas(trade, xi.items.GUNGNIR)
    local TradeKikoku = npcUtil.tradeHas(trade, xi.items.KIKOKU)
    local TradeAmano = npcUtil.tradeHas(trade, xi.items.AMANOMURAKUMO)
    local TradeMjollnir = npcUtil.tradeHas(trade, xi.items.MJOLLNIR)
    local TradeClaustrum = npcUtil.tradeHas(trade, xi.items.CLAUSTRUM)
    local TradeYoichi = npcUtil.tradeHas(trade, xi.items.YOICHINOYUMI)
    local TradeAnnihilator = npcUtil.tradeHas(trade, xi.items.ANNIHILATOR)
    local TradeGjallhorn = npcUtil.tradeHas(trade, xi.items.GJALLARHORN)
    local TradeAegis = npcUtil.tradeHas(trade, xi.items.AEGIS)
	
-- vars for part 2	
	local KikokuExchange = (ExchangeToken == 1 and npcUtil.tradeHas(trade, 18308)) -- ihintanto

-- give player their exchange token
    if Gil == 5000000 and
       (TradeSpharai or TradeMandau or TradeExcalibur or TradeRagnarok or TradeGuttler or TradeBravura or TradeApocalypse or
        TradeGungnir or TradeKikoku or TradeAmano or TradeMjollnir or TradeClaustrum or TradeYoichi or TradeAnnihilator or
        TradeGjallhorn or TradeAegis) then
            player:tradeComplete()
            player:PrintToPlayer("???: You have decided... Now offer me the corresponding vessel and we'll complete the covenant.", 0xD)
            player:setCharVar("[CXI]RelicExchangeToken", 1)
	elseif KikokuExchange then 
	    player:tradeComplete()
		player:setCharVar("[CXI]RelicExchangeToken", 0)
	    player:addItem(xi.items.KIKOKU) 
		player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.KIKOKU)
   	else
        player:PrintToPlayer("???: The covenant states 5,000,000 gil and your existing relic. Don't keep me waiting.", 0xD)
    end
end)

m:addOverride("xi.zones.Sea_Serpent_Grotto.npcs.relic.onTrigger", function(player, npc)
    player:PrintToPlayer("???: Hail to you hardened traveler,", 0xD)
    player:PrintToPlayer("???: Do you desire to switch your ally? Trade your relic back to me together with 5,000,000 gil", 0xD)
	player:PrintToPlayer("???: and I'll exchange it for my soul. Let me return to the battlefield!", 0xD)
end)

m:addOverride("xi.zones.Cape_Terrigan.npcs.relic.onTrade", function(player, npc, trade)
    local ID = require("scripts/zones/Cape_Terrigan/IDs")
    if (player:getCharVar("RELIC_IN_PROGRESS") == xi.items.FUTATOKOROTO and npcUtil.tradeHas(trade, {xi.items.RANPERRE_GOLDPIECE, xi.items.SNARLED_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.FUTATOKOROTO})) then -- currency, shard, necropsyche, stage 4
        player:startEvent(18, xi.items.YOICHINOYUMI)
    end
	
	--  vars for part 1 of the relic exchange program
    local Gil = trade:getGil()
	local ExchangeToken = player:getCharVar("[CXI]RelicExchangeToken")
    local TradeSpharai = npcUtil.tradeHas(trade, xi.items.SPHARAI)
    local TradeMandau = npcUtil.tradeHas(trade, xi.items.MANDAU)
    local TradeExcalibur = npcUtil.tradeHas(trade, xi.items.EXCALIBUR)
    local TradeRagnarok = npcUtil.tradeHas(trade, xi.items.RAGNAROK)
    local TradeGuttler = npcUtil.tradeHas(trade, xi.items.GUTTLER)
    local TradeBravura = npcUtil.tradeHas(trade, xi.items.BRAVURA)
    local TradeApocalypse = npcUtil.tradeHas(trade, xi.items.APOCALYPSE)
    local TradeGungnir = npcUtil.tradeHas(trade, xi.items.GUNGNIR)
    local TradeKikoku = npcUtil.tradeHas(trade, xi.items.KIKOKU)
    local TradeAmano = npcUtil.tradeHas(trade, xi.items.AMANOMURAKUMO)
    local TradeMjollnir = npcUtil.tradeHas(trade, xi.items.MJOLLNIR)
    local TradeClaustrum = npcUtil.tradeHas(trade, xi.items.CLAUSTRUM)
    local TradeYoichi = npcUtil.tradeHas(trade, xi.items.YOICHINOYUMI)
    local TradeAnnihilator = npcUtil.tradeHas(trade, xi.items.ANNIHILATOR)
    local TradeGjallhorn = npcUtil.tradeHas(trade, xi.items.GJALLARHORN)
    local TradeAegis = npcUtil.tradeHas(trade, xi.items.AEGIS)
	
-- vars for part 2	
	local YoichiExchange = (ExchangeToken == 1 and npcUtil.tradeHas(trade, 18344)) -- relic_bow
	
-- give player their exchange token
    if Gil == 5000000 and
       (TradeSpharai or TradeMandau or TradeExcalibur or TradeRagnarok or TradeGuttler or TradeBravura or TradeApocalypse or
        TradeGungnir or TradeKikoku or TradeAmano or TradeMjollnir or TradeClaustrum or TradeYoichi or TradeAnnihilator or
        TradeGjallhorn or TradeAegis) then
            player:tradeComplete()
            player:PrintToPlayer("???: You have decided... Now offer me the corresponding vessel and we'll complete the covenant.", 0xD)
            player:setCharVar("[CXI]RelicExchangeToken", 1)
	elseif YoichiExchange then 
	    player:tradeComplete()
		player:setCharVar("[CXI]RelicExchangeToken", 0)
	    player:addItem(xi.items.YOICHINOYUMI) 
		player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.YOICHINOYUMI)
   	else
        player:PrintToPlayer("???: The covenant states 5,000,000 gil and your existing relic. Don't keep me waiting.", 0xD)
    end
end)

m:addOverride("xi.zones.Cape_Terrigan.npcs.relic.onTrigger", function(player, npc)
    player:PrintToPlayer("???: Hail to you hardened traveler,", 0xD)
    player:PrintToPlayer("???: Do you desire to switch your ally? Trade your relic back to me together with 5,000,000 gil", 0xD)
	player:PrintToPlayer("???: and I'll exchange it for my soul. Let me return to the battlefield!", 0xD)
end)

m:addOverride("xi.zones.Valley_of_Sorrows.npcs.relic.onTrade", function(player, npc, trade)
    local ID = require("scripts/zones/Valley_of_Sorrows/IDs")
    if (player:getCharVar("RELIC_IN_PROGRESS") == xi.items.MILLENNIUM_HORN and npcUtil.tradeHas(trade, {xi.items.RIMILALA_STRIPESHELL, xi.items.MYSTERIAL_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.MILLENNIUM_HORN})) then -- currency, shard, necropsyche, stage 4
        player:startEvent(15, xi.items.GJALLARHORN)
    end
	
--  vars for part 1 of the relic exchange program
    local Gil = trade:getGil()
	local ExchangeToken = player:getCharVar("[CXI]RelicExchangeToken")
    local TradeSpharai = npcUtil.tradeHas(trade, xi.items.SPHARAI)
    local TradeMandau = npcUtil.tradeHas(trade, xi.items.MANDAU)
    local TradeExcalibur = npcUtil.tradeHas(trade, xi.items.EXCALIBUR)
    local TradeRagnarok = npcUtil.tradeHas(trade, xi.items.RAGNAROK)
    local TradeGuttler = npcUtil.tradeHas(trade, xi.items.GUTTLER)
    local TradeBravura = npcUtil.tradeHas(trade, xi.items.BRAVURA)
    local TradeApocalypse = npcUtil.tradeHas(trade, xi.items.APOCALYPSE)
    local TradeGungnir = npcUtil.tradeHas(trade, xi.items.GUNGNIR)
    local TradeKikoku = npcUtil.tradeHas(trade, xi.items.KIKOKU)
    local TradeAmano = npcUtil.tradeHas(trade, xi.items.AMANOMURAKUMO)
    local TradeMjollnir = npcUtil.tradeHas(trade, xi.items.MJOLLNIR)
    local TradeClaustrum = npcUtil.tradeHas(trade, xi.items.CLAUSTRUM)
    local TradeYoichi = npcUtil.tradeHas(trade, xi.items.YOICHINOYUMI)
    local TradeAnnihilator = npcUtil.tradeHas(trade, xi.items.ANNIHILATOR)
    local TradeGjallhorn = npcUtil.tradeHas(trade, xi.items.GJALLARHORN)
    local TradeAegis = npcUtil.tradeHas(trade, xi.items.AEGIS)
	
-- vars for part 2	
	local GjallhornExchange = (ExchangeToken == 1 and npcUtil.tradeHas(trade, 18338)) -- relic_horn

-- give player their exchange token
    if Gil == 5000000 and
       (TradeSpharai or TradeMandau or TradeExcalibur or TradeRagnarok or TradeGuttler or TradeBravura or TradeApocalypse or
        TradeGungnir or TradeKikoku or TradeAmano or TradeMjollnir or TradeClaustrum or TradeYoichi or TradeAnnihilator or
        TradeGjallhorn or TradeAegis) then
            player:tradeComplete()
            player:PrintToPlayer("???: You have decided... Now offer me the corresponding vessel and we'll complete the covenant.", 0xD)
            player:setCharVar("[CXI]RelicExchangeToken", 1)
	elseif GjallhornExchange then 
	    player:tradeComplete()
		player:setCharVar("[CXI]RelicExchangeToken", 0)
	    player:addItem(xi.items.GJALLARHORN) 
		player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.GJALLARHORN)
   	else
        player:PrintToPlayer("???: The covenant states 5,000,000 gil and your existing relic. Don't keep me waiting.", 0xD)
    end
end)

m:addOverride("xi.zones.Valley_of_Sorrows.npcs.relic.onTrigger", function(player, npc)
    player:PrintToPlayer("???: Hail to you hardened traveler,", 0xD)
    player:PrintToPlayer("???: Do you desire to switch your ally? Trade your relic back to me together with 5,000,000 gil", 0xD)
	player:PrintToPlayer("???: and I'll exchange it for my soul. Let me return to the battlefield!", 0xD)
end)

m:addOverride("xi.zones.Western_Altepa_Desert.npcs.relic.onTrade", function(player, npc, trade)
    local ID = require("scripts/zones/Western_Altepa_Desert/IDs")
    if player:getCharVar("RELIC_IN_PROGRESS") == xi.items.OGRE_KILLER and npcUtil.tradeHas(trade, {xi.items.RIMILALA_STRIPESHELL, xi.items.RUNAEIC_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.OGRE_KILLER}) then -- currency, shard, necropsyche, stage 4
        player:startEvent(205, xi.items.GUTTLER)
    end
	
	--  vars for part 1 of the relic exchange program
    local Gil = trade:getGil()
	local ExchangeToken = player:getCharVar("[CXI]RelicExchangeToken")
    local TradeSpharai = npcUtil.tradeHas(trade, xi.items.SPHARAI)
    local TradeMandau = npcUtil.tradeHas(trade, xi.items.MANDAU)
    local TradeExcalibur = npcUtil.tradeHas(trade, xi.items.EXCALIBUR)
    local TradeRagnarok = npcUtil.tradeHas(trade, xi.items.RAGNAROK)
    local TradeGuttler = npcUtil.tradeHas(trade, xi.items.GUTTLER)
    local TradeBravura = npcUtil.tradeHas(trade, xi.items.BRAVURA)
    local TradeApocalypse = npcUtil.tradeHas(trade, xi.items.APOCALYPSE)
    local TradeGungnir = npcUtil.tradeHas(trade, xi.items.GUNGNIR)
    local TradeKikoku = npcUtil.tradeHas(trade, xi.items.KIKOKU)
    local TradeAmano = npcUtil.tradeHas(trade, xi.items.AMANOMURAKUMO)
    local TradeMjollnir = npcUtil.tradeHas(trade, xi.items.MJOLLNIR)
    local TradeClaustrum = npcUtil.tradeHas(trade, xi.items.CLAUSTRUM)
    local TradeYoichi = npcUtil.tradeHas(trade, xi.items.YOICHINOYUMI)
    local TradeAnnihilator = npcUtil.tradeHas(trade, xi.items.ANNIHILATOR)
    local TradeGjallhorn = npcUtil.tradeHas(trade, xi.items.GJALLARHORN)
    local TradeAegis = npcUtil.tradeHas(trade, xi.items.AEGIS)
	
-- vars for part 2	
	local GuttlerExchange = (ExchangeToken == 1 and npcUtil.tradeHas(trade, 18284)) -- relic_axe

-- give player their exchange token
    if Gil == 5000000 and
       (TradeSpharai or TradeMandau or TradeExcalibur or TradeRagnarok or TradeGuttler or TradeBravura or TradeApocalypse or
        TradeGungnir or TradeKikoku or TradeAmano or TradeMjollnir or TradeClaustrum or TradeYoichi or TradeAnnihilator or
        TradeGjallhorn or TradeAegis) then
            player:tradeComplete()
            player:PrintToPlayer("???: You have decided... Now offer me the corresponding vessel and we'll complete the covenant.", 0xD)
            player:setCharVar("[CXI]RelicExchangeToken", 1)
	elseif GuttlerExchange then 
	    player:tradeComplete()
		player:setCharVar("[CXI]RelicExchangeToken", 0)
	    player:addItem(xi.items.GUTTLER) 
		player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.GUTTLER)
   	else
        player:PrintToPlayer("???: The covenant states 5,000,000 gil and your existing relic. Don't keep me waiting.", 0xD)
    end
end)

m:addOverride("xi.zones.Western_Altepa_Desert.npcs.relic.onTrigger", function(player, npc)
    player:PrintToPlayer("???: Hail to you hardened traveler,", 0xD)
    player:PrintToPlayer("???: Do you desire to switch your ally? Trade your relic back to me together with 5,000,000 gil", 0xD)
	player:PrintToPlayer("???: and I'll exchange it for my soul. Let me return to the battlefield!", 0xD)
end)

m:addOverride("xi.zones.The_Sanctuary_of_ZiTah.npcs.relic.onTrade", function(player, npc, trade)
    local ID = require("scripts/zones/The_Sanctuary_of_ZiTah/IDs")
    local currentRelic = player:getCharVar("RELIC_IN_PROGRESS")

    -- Mandau
    if currentRelic == xi.items.BATARDEAU and npcUtil.tradeHas(trade, {xi.items.TEN_THOUSAND_BYNE_BILL, xi.items.ORNATE_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.BATARDEAU}) then -- currency, shard, necropsyche, stage 4
        player:startEvent(207, xi.items.MANDAU)

    -- Mjollnir
    elseif currentRelic == xi.items.GULLINTANI and npcUtil.tradeHas(trade, {xi.items.RANPERRE_GOLDPIECE, xi.items.HEAVENLY_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.GULLINTANI}) then -- currency, shard, necropsyche, stage 4
        player:startEvent(216, xi.items.MJOLLNIR)
    end
	
	--  vars for part 1 of the relic exchange program
    local Gil = trade:getGil()
	local ExchangeToken = player:getCharVar("[CXI]RelicExchangeToken")
    local TradeSpharai = npcUtil.tradeHas(trade, xi.items.SPHARAI)
    local TradeMandau = npcUtil.tradeHas(trade, xi.items.MANDAU)
    local TradeExcalibur = npcUtil.tradeHas(trade, xi.items.EXCALIBUR)
    local TradeRagnarok = npcUtil.tradeHas(trade, xi.items.RAGNAROK)
    local TradeGuttler = npcUtil.tradeHas(trade, xi.items.GUTTLER)
    local TradeBravura = npcUtil.tradeHas(trade, xi.items.BRAVURA)
    local TradeApocalypse = npcUtil.tradeHas(trade, xi.items.APOCALYPSE)
    local TradeGungnir = npcUtil.tradeHas(trade, xi.items.GUNGNIR)
    local TradeKikoku = npcUtil.tradeHas(trade, xi.items.KIKOKU)
    local TradeAmano = npcUtil.tradeHas(trade, xi.items.AMANOMURAKUMO)
    local TradeMjollnir = npcUtil.tradeHas(trade, xi.items.MJOLLNIR)
    local TradeClaustrum = npcUtil.tradeHas(trade, xi.items.CLAUSTRUM)
    local TradeYoichi = npcUtil.tradeHas(trade, xi.items.YOICHINOYUMI)
    local TradeAnnihilator = npcUtil.tradeHas(trade, xi.items.ANNIHILATOR)
    local TradeGjallhorn = npcUtil.tradeHas(trade, xi.items.GJALLARHORN)
    local TradeAegis = npcUtil.tradeHas(trade, xi.items.AEGIS)
	
-- vars for part 2	
	local MandauExchange = (ExchangeToken == 1 and npcUtil.tradeHas(trade, 18266)) -- relic_dagger
	local MjollnirExchange = (ExchangeToken == 1 and npcUtil.tradeHas(trade, 18320)) -- relic_maul

-- give player their exchange token
    if Gil == 5000000 and
       (TradeSpharai or TradeMandau or TradeExcalibur or TradeRagnarok or TradeGuttler or TradeBravura or TradeApocalypse or
        TradeGungnir or TradeKikoku or TradeAmano or TradeMjollnir or TradeClaustrum or TradeYoichi or TradeAnnihilator or
        TradeGjallhorn or TradeAegis) then
            player:tradeComplete()
            player:PrintToPlayer("???: You have decided... Now offer me the corresponding vessel and we'll complete the covenant.", 0xD)
            player:setCharVar("[CXI]RelicExchangeToken", 1)
	elseif MandauExchange then 
	    player:tradeComplete()
		player:setCharVar("[CXI]RelicExchangeToken", 0)
	    player:addItem(xi.items.MANDAU) 
		player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.MANDAU)
	elseif MjollnirExchange then 
	    player:tradeComplete()
		player:setCharVar("[CXI]RelicExchangeToken", 0)
	    player:addItem(xi.items.MJOLLNIR) 
		player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.MJOLLNIR)
   	else
        player:PrintToPlayer("???: The covenant states 5,000,000 gil and your existing relic. Don't keep me waiting.", 0xD)
    end
end)

m:addOverride("xi.zones.The_Sanctuary_of_ZiTah.npcs.relic.onTrigger", function(player, npc)
    player:PrintToPlayer("???: Hail to you hardened traveler,", 0xD)
    player:PrintToPlayer("???: Do you desire to switch your ally? Trade your relic back to me together with 5,000,000 gil", 0xD)
	player:PrintToPlayer("???: and I'll exchange it for my soul. Let me return to the battlefield!", 0xD)
end)

return m 