-----------------------------------
-- CatsEyeXI Relic System
-----------------------------------
require("modules/module_utils")
require("scripts/globals/items")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/status")

local relicSystem = Module:new("crafting_relics_and_exchanges")

local rTable = 
{     
    [1]  = { xi.items.SPHARAI       },
    [2]  = { xi.items.MANDAU        },
    [3]  = { xi.items.EXCALIBUR     },
    [4]  = { xi.items.RAGNAROK      },
    [5]  = { xi.items.GUTTLER       },
    [6]  = { xi.items.BRAVURA       },
    [7]  = { xi.items.APOCALYPSE    },
    [8]  = { xi.items.GUNGNIR       },
    [9]  = { xi.items.KIKOKU        },
    [10] = { xi.items.AMANOMURAKUMO },
    [11] = { xi.items.MJOLLNIR      },
    [12] = { xi.items.CLAUSTRUM     },
    [13] = { xi.items.YOICHINOYUMI  },
    [14] = { xi.items.ANNIHILATOR   },
    [15] = { xi.items.GJALLARHORN   },	
	[16] = { xi.items.AEGIS         },
}

relicSystem:addOverride("xi.zones.The_Sanctuary_of_ZiTah.npcs.relic_mandau.onTrigger", function(player, npc, trade)    
    local ID = require("scripts/zones/The_Sanctuary_of_ZiTah/IDs")
    if player:getCharVar("RelicWeaponVoucher") == 1 then
	    player:setCharVar("RelicWeaponVoucher", 0)
		npcUtil.giveItem(player, xi.items.MANDAU)
	else
	    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
	end
end)

relicSystem:addOverride("xi.zones.The_Sanctuary_of_ZiTah.npcs.relic_mjollnir.onTrigger", function(player, npc, trade)    
    local ID = require("scripts/zones/The_Sanctuary_of_ZiTah/IDs")
    if player:getCharVar("RelicWeaponVoucher") == 1 then
	    player:setCharVar("RelicWeaponVoucher", 0)
		npcUtil.giveItem(player, xi.items.MJOLLNIR)
	else
	    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
	end
end)

relicSystem:addOverride("xi.zones.Castle_Oztroja.npcs.relic.onTrigger", function(player, npc, trade)    
    local ID = require("scripts/zones/Castle_Oztroja/IDs")
    if player:getCharVar("RelicWeaponVoucher") == 1 then
	    player:setCharVar("RelicWeaponVoucher", 0)
		npcUtil.giveItem(player, xi.items.SPHARAI)
	else
	    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
	end
end)

relicSystem:addOverride("xi.zones.Dragons_Aery.npcs.relic.onTrigger", function(player, npc, trade)
    local ID = require("scripts/zones/Dragons_Aery/IDs")
    if player:getCharVar("RelicWeaponVoucher") == 1 then
	    player:setCharVar("RelicWeaponVoucher", 0)
		npcUtil.giveItem(player, xi.items.EXCALIBUR)
	else
	    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
	end
end)

relicSystem:addOverride("xi.zones.Western_Altepa_Desert.npcs.relic.onTrigger", function(player, npc, trade)
    local ID = require("scripts/zones/Western_Altepa_Desert/IDs")
    if player:getCharVar("RelicWeaponVoucher") == 1 then
	    player:setCharVar("RelicWeaponVoucher", 0)
		npcUtil.giveItem(player, xi.items.GUTTLER)
	else
	    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
	end
end)

relicSystem:addOverride("xi.zones.RuAun_Gardens.npcs.relic.onTrigger", function(player, npc, trade)
    local ID = require("scripts/zones/RuAun_Gardens/IDs")
    if player:getCharVar("RelicWeaponVoucher") == 1 then
	    player:setCharVar("RelicWeaponVoucher", 0)
		npcUtil.giveItem(player, xi.items.GUNGNIR)
	else
	    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
	end
end)

relicSystem:addOverride("xi.zones.Beaucedine_Glacier.npcs.relic.onTrigger", function(player, npc, trade)
    local ID = require("scripts/zones/Beaucedine_Glacier/IDs")
    if player:getCharVar("RelicWeaponVoucher") == 1 then
	    player:setCharVar("RelicWeaponVoucher", 0)
		npcUtil.giveItem(player, xi.items.RAGNAROK)
	else
	    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
	end
end)

relicSystem:addOverride("xi.zones.Valley_of_Sorrows.npcs.relic.onTrigger", function(player, npc, trade)
    local ID = require("scripts/zones/Valley_of_Sorrows/IDs")
    if player:getCharVar("RelicWeaponVoucher") == 1 then
	    player:setCharVar("RelicWeaponVoucher", 0)
		npcUtil.giveItem(player, xi.items.GJALLARHORN)
	else
	    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
	end
end)

relicSystem:addOverride("xi.zones.RuLude_Gardens.npcs.relic.onTrigger", function(player, npc, trade)
    local ID = require("scripts/zones/RuLude_Gardens/IDs")
    if player:getCharVar("RelicWeaponVoucher") == 1 then
	    player:setCharVar("RelicWeaponVoucher", 0)
		npcUtil.giveItem(player, xi.items.BRAVURA)
	else
	    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
	end
end)

relicSystem:addOverride("xi.zones.Horlais_Peak.npcs.relic.onTrigger", function(player, npc, trade)
    local ID = require("scripts/zones/Horlais_Peak/IDs")
    if player:getCharVar("RelicWeaponVoucher") == 1 then
	    player:setCharVar("RelicWeaponVoucher", 0)
		npcUtil.giveItem(player, xi.items.AMANOMURAKUMO)
	else
	    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
	end
end)

relicSystem:addOverride("xi.zones.North_Gustaberg.npcs.relic.onTrigger", function(player, npc, trade)
    local ID = require("scripts/zones/North_Gustaberg/IDs")
    if player:getCharVar("RelicWeaponVoucher") == 1 then
	    player:setCharVar("RelicWeaponVoucher", 0)
		npcUtil.giveItem(player, xi.items.APOCALYPSE)
	else
	    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
	end
end)

relicSystem:addOverride("xi.zones.Carpenters_Landing.npcs.relic.onTrigger", function(player, npc, trade)
    local ID = require("scripts/zones/Carpenters_Landing/IDs")
    if player:getCharVar("RelicWeaponVoucher") == 1 then
	    player:setCharVar("RelicWeaponVoucher", 0)
		npcUtil.giveItem(player, xi.items.AEGIS)
	else
	    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
	end
end)

relicSystem:addOverride("xi.zones.Sea_Serpent_Grotto.npcs.relic.onTrigger", function(player, npc, trade)
    local ID = require("scripts/zones/Sea_Serpent_Grotto/IDs")
    if player:getCharVar("RelicWeaponVoucher") == 1 then
	    player:setCharVar("RelicWeaponVoucher", 0)
		npcUtil.giveItem(player, xi.items.KIKOKU)
	else
	    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
	end
end)

relicSystem:addOverride("xi.zones.Ifrits_Cauldron.npcs.relic.onTrigger", function(player, npc, trade)
    local ID = require("scripts/zones/Ifrits_Cauldron/IDs")
    if player:getCharVar("RelicWeaponVoucher") == 1 then
	    player:setCharVar("RelicWeaponVoucher", 0)
		npcUtil.giveItem(player, xi.items.CLAUSTRUM)
	else
	    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
	end
end)

relicSystem:addOverride("xi.zones.Cape_Teriggan.npcs.relic.onTrigger", function(player, npc, trade)
    local ID = require("scripts/zones/Cape_Teriggan/IDs")
    if player:getCharVar("RelicWeaponVoucher") == 1 then
	    player:setCharVar("RelicWeaponVoucher", 0)
		npcUtil.giveItem(player, xi.items.YOICHINOYUMI)
	else
	    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
	end
end)

relicSystem:addOverride("xi.zones.Metalworks.npcs.relic.onTrigger", function(player, npc, trade)
    local ID = require("scripts/zones/Metalworks/IDs")
    if player:getCharVar("RelicWeaponVoucher") == 1 then
	    player:setCharVar("RelicWeaponVoucher", 0)
		npcUtil.giveItem(player, xi.items.ANNIHILATOR)
	else
	    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
	end
end)

relicSystem:addOverride("xi.zones.The_Sanctuary_of_ZiTah.npcs.relic_mandau.onTrade", function(player, npc, trade)    
    local currentRelic = player:getCharVar("RELIC_IN_PROGRESS")

    if currentRelic == xi.items.BATARDEAU and npcUtil.tradeHas(trade, {xi.items.TEN_THOUSAND_BYNE_BILL, xi.items.ORNATE_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.BATARDEAU}) then -- currency, shard, necropsyche, stage 4
        player:startEvent(207, xi.items.MANDAU)
    elseif trade:getGil() == 5000000 then
        for i = 1, 16 do
            local itemId = rTable[i][1]

            if npcUtil.tradeHas(trade, itemId) then
                if npcUtil.giveItem(player, xi.items.MANDAU) then
                    player:tradeComplete()
                end

                break
            end
        end
    end
end)

relicSystem:addOverride("xi.zones.The_Sanctuary_of_ZiTah.npcs.relic_mjollnir.onTrade", function(player, npc, trade)    
    local currentRelic = player:getCharVar("RELIC_IN_PROGRESS")

    if currentRelic == xi.items.GULLINTANI and npcUtil.tradeHas(trade, {xi.items.RANPERRE_GOLDPIECE, xi.items.HEAVENLY_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.GULLINTANI}) then -- currency, shard, necropsyche, stage 4
        player:startEvent(216, xi.items.MJOLLNIR)
    elseif trade:getGil() == 5000000 then
        for i = 1, 16 do
            local itemId = rTable[i][1]

            if npcUtil.tradeHas(trade, itemId) then
                if npcUtil.giveItem(player, xi.items.MJOLLNIR) then
                    player:tradeComplete()
                end

                break
            end
        end
    end
end)

relicSystem:addOverride("xi.zones.Castle_Oztroja.npcs.relic.onTrade", function(player, npc, trade)    
    if
        player:getCharVar("RELIC_IN_PROGRESS") == xi.items.CAESTUS and
        npcUtil.tradeHas(trade, {xi.items.TEN_THOUSAND_BYNE_BILL, xi.items.MYSTIC_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.CAESTUS})
    then -- currency, shard, necropsyche, stage 4
        player:startEvent(59, xi.items.SPHARAI)
    elseif trade:getGil() == 5000000 then
        for i = 1, 16 do
            local itemId = rTable[i][1]

            if npcUtil.tradeHas(trade, itemId) then
                if npcUtil.giveItem(player, xi.items.SPHARAI) then
                    player:tradeComplete()
                end

                break
            end
        end
    end
end)

relicSystem:addOverride("xi.zones.Dragons_Aery.npcs.relic.onTrade", function(player, npc, trade)
    if
        player:getCharVar("RELIC_IN_PROGRESS") == xi.items.CALIBURN and
        npcUtil.tradeHas(trade, {xi.items.RANPERRE_GOLDPIECE, xi.items.HOLY_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.CALIBURN})
    then -- currency, shard, necropsyche, stage 4
        player:startEvent(3, xi.items.EXCALIBUR)
    elseif trade:getGil() == 5000000 then
        for i = 1, 16 do
            local itemId = rTable[i][1]

            if npcUtil.tradeHas(trade, itemId) then
                if npcUtil.giveItem(player, xi.items.EXCALIBUR) then
                    player:tradeComplete()
                end

                break
            end
        end
    end
end)

relicSystem:addOverride("xi.zones.Western_Altepa_Desert.npcs.relic.onTrade", function(player, npc, trade)
    if
        player:getCharVar("RELIC_IN_PROGRESS") == xi.items.OGRE_KILLER and
        npcUtil.tradeHas(trade, {xi.items.RIMILALA_STRIPESHELL, xi.items.RUNAEIC_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.OGRE_KILLER})
    then -- currency, shard, necropsyche, stage 4
        player:startEvent(205, xi.items.GUTTLER)
    elseif trade:getGil() == 5000000 then
        for i = 1, 16 do
            local itemId = rTable[i][1]

            if npcUtil.tradeHas(trade, itemId) then
                if npcUtil.giveItem(player, xi.items.GUTTLER) then
                    player:tradeComplete()
                end

                break
            end
        end
    end
end)


relicSystem:addOverride("xi.zones.RuAun_Gardens.npcs.relic.onTrade", function(player, npc, trade)
    if player:getCharVar("RELIC_IN_PROGRESS") == xi.items.GAE_ASSAIL and
        npcUtil.tradeHasExactly(trade, {xi.items.RIMILALA_STRIPESHELL, xi.items.STELLAR_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.GAE_ASSAIL})
    then -- currency, shard, necropsyche, stage 4
        player:startEvent(60, xi.items.GUNGNIR)
    elseif trade:getGil() == 5000000 then
        for i = 1, 16 do
            local itemId = rTable[i][1]

            if npcUtil.tradeHas(trade, itemId) then
                if npcUtil.giveItem(player, xi.items.GUNGNIR) then
                    player:tradeComplete()
                end

                break
            end
        end
    end
end)


relicSystem:addOverride("xi.zones.Beaucedine_Glacier.npcs.relic.onTrade", function(player, npc, trade)
    if
        player:getCharVar("RELIC_IN_PROGRESS") == xi.items.VALHALLA and
        npcUtil.tradeHas(trade, {xi.items.RANPERRE_GOLDPIECE, xi.items.INTRICATE_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.VALHALLA})
    then -- currency, shard, necropsyche, stage 4
        player:startEvent(139, xi.items.RAGNAROK)
    elseif trade:getGil() == 5000000 then
        for i = 1, 16 do
            local itemId = rTable[i][1]

            if npcUtil.tradeHas(trade, itemId) then
                if npcUtil.giveItem(player, xi.items.RAGNAROK) then
                    player:tradeComplete()
                end

                break
            end
        end
    end
end)

relicSystem:addOverride("xi.zones.Valley_of_Sorrows.npcs.relic.onTrade", function(player, npc, trade)
    if (player:getCharVar("RELIC_IN_PROGRESS") == xi.items.MILLENNIUM_HORN and npcUtil.tradeHas(trade, {xi.items.RIMILALA_STRIPESHELL, xi.items.MYSTERIAL_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.MILLENNIUM_HORN})) then -- currency, shard, necropsyche, stage 4
        player:startEvent(15, xi.items.GJALLARHORN)
    elseif trade:getGil() == 5000000 then
        for i = 1, 16 do
            local itemId = rTable[i][1]

            if npcUtil.tradeHas(trade, itemId) then
                if npcUtil.giveItem(player, xi.items.GJALLARHORN) then
                    player:tradeComplete()
                end

                break
            end
        end
    end
end)

relicSystem:addOverride("xi.zones.RuLude_Gardens.npcs.relic.onTrade", function(player, npc, trade)
    if player:getCharVar("RELIC_IN_PROGRESS") == xi.items.ABADDON_KILLER and
        npcUtil.tradeHas(trade, {xi.items.TEN_THOUSAND_BYNE_BILL, xi.items.SERAPHIC_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.ABADDON_KILLER})
    then -- currency, shard, necropsyche, stage 4
        player:startEvent(10035, xi.items.BRAVURA)
    elseif trade:getGil() == 5000000 then
        for i = 1, 16 do
            local itemId = rTable[i][1]

            if npcUtil.tradeHas(trade, itemId) then
                if npcUtil.giveItem(player, xi.items.BRAVURA) then
                    player:tradeComplete()
                end

                break
            end
        end
    end
end)

relicSystem:addOverride("xi.zones.Horlais_Peak.npcs.relic.onTrade", function(player, npc, trade)
    if (player:getCharVar("RELIC_IN_PROGRESS") == xi.items.TOTSUKANOTSURUGI and npcUtil.tradeHas(trade, {xi.items.RANPERRE_GOLDPIECE, xi.items.DIVINE_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.TOTSUKANOTSURUGI})) then -- currency, shard, necropsyche, stage 4
        player:startEvent(13, xi.items.AMANOMURAKUMO)
    elseif trade:getGil() == 5000000 then
        for i = 1, 16 do
            local itemId = rTable[i][1]

            if npcUtil.tradeHas(trade, itemId) then
                if npcUtil.giveItem(player, xi.items.AMANOMURAKUMO) then
                    player:tradeComplete()
                end

                break
            end
        end
    end
end)

relicSystem:addOverride("xi.zones.North_Gustaberg.npcs.relic.onTrade", function(player, npc, trade)
    if player:getCharVar("RELIC_IN_PROGRESS") == xi.items.BEC_DE_FAUCON and npcUtil.tradeHas(trade, {xi.items.RIMILALA_STRIPESHELL, xi.items.TENEBROUS_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.BEC_DE_FAUCON}) then -- currency, shard, necropsyche, stage 4
        player:startEvent(254, xi.items.APOCALYPSE)
    elseif trade:getGil() == 5000000 then
        for i = 1, 16 do
            local itemId = rTable[i][1]

            if npcUtil.tradeHas(trade, itemId) then
                if npcUtil.giveItem(player, xi.items.APOCALYPSE) then
                    player:tradeComplete()
                end

                break
            end
        end
    end
end)

relicSystem:addOverride("xi.zones.Carpenters_Landing.npcs.relic.onTrade", function(player, npc, trade)
    if (player:getCharVar("RELIC_IN_PROGRESS") == xi.items.ANCILE and npcUtil.tradeHas(trade, {xi.items.RANPERRE_GOLDPIECE, xi.items.SUPERNAL_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.ANCILE})) then -- currency, shard, necropsyche, stage 4
        player:startEvent(44, xi.items.AEGIS)
    elseif trade:getGil() == 5000000 then
        for i = 1, 16 do
            local itemId = rTable[i][1]

            if npcUtil.tradeHas(trade, itemId) then
                if npcUtil.giveItem(player, xi.items.AEGIS) then
                    player:tradeComplete()
                end

                break
            end
        end
    end
end)

relicSystem:addOverride("xi.zones.Sea_Serpent_Grotto.npcs.relic.onTrade", function(player, npc, trade)
    if player:getCharVar("RELIC_IN_PROGRESS") == xi.items.YOSHIMITSU and npcUtil.tradeHas(trade, {xi.items.TEN_THOUSAND_BYNE_BILL, xi.items.DEMONIAC_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.YOSHIMITSU}) then -- currency, shard, necropsyche, stage 4
        player:startEvent(11, xi.items.KIKOKU)
    elseif trade:getGil() == 5000000 then
        for i = 1, 16 do
            local itemId = rTable[i][1]

            if npcUtil.tradeHas(trade, itemId) then
                if npcUtil.giveItem(player, xi.items.KIKOKU) then
                    player:tradeComplete()
                end

                break
            end
        end
    end
end)

relicSystem:addOverride("xi.zones.Ifrits_Cauldron.npcs.relic.onTrade", function(player, npc, trade)
    if player:getCharVar("RELIC_IN_PROGRESS") == xi.items.THYRUS and
        npcUtil.tradeHas(trade, {xi.items.RIMILALA_STRIPESHELL, xi.items.CELESTIAL_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.THYRUS}) -- currency, shard, necropsyche, stage 4
    then
        player:startEvent(32, xi.items.CLAUSTRUM)
    elseif trade:getGil() == 5000000 then
        for i = 1, 16 do
            local itemId = rTable[i][1]

            if npcUtil.tradeHas(trade, itemId) then
                if npcUtil.giveItem(player, xi.items.CLAUSTRUM) then
                    player:tradeComplete()
                end

                break
            end
        end
    end
end)

relicSystem:addOverride("xi.zones.Cape_Teriggan.npcs.relic.onTrade", function(player, npc, trade)
    if player:getCharVar("RELIC_IN_PROGRESS") == xi.items.FUTATOKOROTO and npcUtil.tradeHas(trade, {xi.items.RANPERRE_GOLDPIECE, xi.items.SNARLED_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.FUTATOKOROTO}) then -- currency, shard, necropsyche, stage 4
        player:startEvent(18, xi.items.YOICHINOYUMI)
    elseif trade:getGil() == 5000000 then
        for i = 1, 16 do
            local itemId = rTable[i][1]

            if npcUtil.tradeHas(trade, itemId) then
                if npcUtil.giveItem(player, xi.items.YOICHINOYUMI) then
                    player:tradeComplete()
                end

                break
            end
        end
    end
end)

relicSystem:addOverride("xi.zones.Metalworks.npcs.relic.onTrade", function(player, npc, trade)
    if player:getCharVar("RELIC_IN_PROGRESS") == xi.items.FERDINAND and npcUtil.tradeHas(trade, {xi.items.TEN_THOUSAND_BYNE_BILL, xi.items.ETHEREAL_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.FERDINAND}) then -- currency, shard, necropsyche, stage 4
        player:startEvent(843, xi.items.ANNIHILATOR)
    elseif trade:getGil() == 5000000 then
        for i = 1, 16 do
            local itemId = rTable[i][1]

            if npcUtil.tradeHas(trade, itemId) then
                if npcUtil.giveItem(player, xi.items.ANNIHILATOR) then
                    player:tradeComplete()
                end

                break
            end
        end
    end
end)

-- Start Crafting Relics (Momiji, Lower Jeuno)

relicSystem:addOverride("xi.zones.Lower_Jeuno.npcs.Momiji.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Lower_Jeuno/IDs")
	
	if player:getCharVar("FreeRelic") == 1 then
        player:PrintToPlayer("Momiji: Looks like you've already gotten your free relic, you can't have another.", 0xD)
        return
    end
    
	for i = xi.skill.FISHING, xi.skill.COOKING do
	    print(i)
        if player:getCharSkillLevel(i) >= 600 and player:hasKeyItem(xi.keyItem.RHAPSODY_IN_WHITE) == false
		    then
		        npcUtil.giveKeyItem(player, xi.keyItem.RHAPSODY_IN_WHITE)
			    player:PrintToPlayer(string.format( "Momiji: You have earned this, congratulations!\n"))
			
			    break
		elseif player:getCharSkillLevel(i) >= 800 and player:hasKeyItem(xi.keyItem.RHAPSODY_IN_CRIMSON) == false
		    then
		        npcUtil.giveKeyItem(player, xi.keyItem.RHAPSODY_IN_CRIMSON)
			    player:PrintToPlayer(string.format( "Momiji: You have earned this, congratulations!\n"))
			    
				break
		elseif player:getCharSkillLevel(i) >= 1000
		    then
                player:PrintToPlayer("Momiji: Congratulations Grand Master, here is your relic weapon voucher. Visit the corresponding ???", 0xD)
                player:PrintToPlayer("to accept your new weapon!", 0xD)
                player:setCharVar("FreeRelic", 1)
                player:setCharVar("RelicWeaponVoucher", 1)
		end
	end
end)

return relicSystem