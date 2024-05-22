-----------------------------------
-- Image Support NPCs
-----------------------------------
require('scripts/globals/crafting/crafting_utils')
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.crafting = xi.crafting or {}

local npcTable =
{
    --    ['npc_name'] = { type, event, guild_id,           skill_id,              effect_id,                     },
    ['Panja-Nanja'   ] = { 0, 10011, xi.guild.FISHING,      xi.skill.FISHING,      xi.effect.FISHING_IMAGERY      }, -- Advanced
    ['Erabu-Fumulubu'] = { 1, 10012, xi.guild.FISHING,      xi.skill.FISHING,      xi.effect.FISHING_IMAGERY      }, -- Free
    ['Degong'        ] = { 2, 10013, xi.guild.FISHING,      xi.skill.FISHING,      xi.effect.FISHING_IMAGERY      }, -- Free
    ['Ulycille'      ] = { 0,   623, xi.guild.WOODWORKING,  xi.skill.WOODWORKING,  xi.effect.WOODWORKING_IMAGERY  }, -- Advanced
    ['Amarefice'     ] = { 1,   624, xi.guild.WOODWORKING,  xi.skill.WOODWORKING,  xi.effect.WOODWORKING_IMAGERY  }, -- Free
    ['Ramua'         ] = { 2,   625, xi.guild.WOODWORKING,  xi.skill.WOODWORKING,  xi.effect.WOODWORKING_IMAGERY  }, -- Free
    ['Wise_Owl'      ] = { 0,   103, xi.guild.SMITHING,     xi.skill.SMITHING,     xi.effect.SMITHING_IMAGERY     }, -- Advanced
    ['Hugues'        ] = { 1,   104, xi.guild.SMITHING,     xi.skill.SMITHING,     xi.effect.SMITHING_IMAGERY     }, -- Free
    ['Romero'        ] = { 2,   105, xi.guild.SMITHING,     xi.skill.SMITHING,     xi.effect.SMITHING_IMAGERY     }, -- Free
    ['Greubaque'     ] = { 0,   628, xi.guild.SMITHING,     xi.skill.SMITHING,     xi.effect.SMITHING_IMAGERY     }, -- Advanced
    ['Pinok-Morok'   ] = { 1,   629, xi.guild.SMITHING,     xi.skill.SMITHING,     xi.effect.SMITHING_IMAGERY     }, -- Free
    ['Beadurinc'     ] = { 2,   630, xi.guild.SMITHING,     xi.skill.SMITHING,     xi.effect.SMITHING_IMAGERY     }, -- Free
    ['Fatimah'       ] = { 0,   302, xi.guild.GOLDSMITHING, xi.skill.GOLDSMITHING, xi.effect.GOLDSMITHING_IMAGERY }, -- Advanced
    ['Wulfnoth'      ] = { 1,   303, xi.guild.GOLDSMITHING, xi.skill.GOLDSMITHING, xi.effect.GOLDSMITHING_IMAGERY }, -- Free
    ['Ulrike'        ] = { 2,   304, xi.guild.GOLDSMITHING, xi.skill.GOLDSMITHING, xi.effect.GOLDSMITHING_IMAGERY }, -- Free
    ['Terude-Harude' ] = { 0, 10013, xi.guild.CLOTHCRAFT,   xi.skill.CLOTHCRAFT,   xi.effect.CLOTHCRAFT_IMAGERY   }, -- Advanced
    ['Nikkoko'       ] = { 1, 10014, xi.guild.CLOTHCRAFT,   xi.skill.CLOTHCRAFT,   xi.effect.CLOTHCRAFT_IMAGERY   }, -- Free
    ['Anillah'       ] = { 2, 10015, xi.guild.CLOTHCRAFT,   xi.skill.CLOTHCRAFT,   xi.effect.CLOTHCRAFT_IMAGERY   }, -- Free
    ['Orechiniel'    ] = { 0,   650, xi.guild.LEATHERCRAFT, xi.skill.LEATHERCRAFT, xi.effect.LEATHERCRAFT_IMAGERY }, -- Advanced
    ['Kipopo'        ] = { 1,   651, xi.guild.LEATHERCRAFT, xi.skill.LEATHERCRAFT, xi.effect.LEATHERCRAFT_IMAGERY }, -- Free
    ['Tek_Lengyon'   ] = { 2,   652, xi.guild.LEATHERCRAFT, xi.skill.LEATHERCRAFT, xi.effect.LEATHERCRAFT_IMAGERY }, -- Free
    ['Lih_Pituu'     ] = { 0, 10018, xi.guild.BONECRAFT,    xi.skill.BONECRAFT,    xi.effect.BONECRAFT_IMAGERY    }, -- Advanced
    ['Ronana'        ] = { 1, 10019, xi.guild.BONECRAFT,    xi.skill.BONECRAFT,    xi.effect.BONECRAFT_IMAGERY    }, -- Free
    ['Kyaa_Taali'    ] = { 2, 10020, xi.guild.BONECRAFT,    xi.skill.BONECRAFT,    xi.effect.BONECRAFT_IMAGERY    }, -- Free
    ['Azima'         ] = { 0,   122, xi.guild.ALCHEMY,      xi.skill.ALCHEMY,      xi.effect.ALCHEMY_IMAGERY      }, -- Advanced
    ['Titus'         ] = { 1,   123, xi.guild.ALCHEMY,      xi.skill.ALCHEMY,      xi.effect.ALCHEMY_IMAGERY      }, -- Free
    ['Sieglinde'     ] = { 2,   124, xi.guild.ALCHEMY,      xi.skill.ALCHEMY,      xi.effect.ALCHEMY_IMAGERY      }, -- Free
    ['Kipo-Opo'      ] = { 0, 10015, xi.guild.COOKING,      xi.skill.COOKING,      xi.effect.COOKING_IMAGERY      }, -- Advanced
    ['Jacodaut'      ] = { 1, 10016, xi.guild.COOKING,      xi.skill.COOKING,      xi.effect.COOKING_IMAGERY      }, -- Free
    ['Hakeem'        ] = { 2, 10017, xi.guild.COOKING,      xi.skill.COOKING,      xi.effect.COOKING_IMAGERY      }, -- Free
    ['Kemha_Flasehp' ] = { 0,   642, xi.guild.FISHING,      xi.skill.FISHING,      xi.effect.FISHING_IMAGERY      }, -- Dual
    ['Yudi_Yolhbi'   ] = { 0,   234, xi.guild.WOODWORKING,  xi.skill.WOODWORKING,  xi.effect.WOODWORKING_IMAGERY  }, -- Dual
    ['Macici'        ] = { 0,   232, xi.guild.SMITHING,     xi.skill.SMITHING,     xi.effect.SMITHING_IMAGERY     }, -- Dual
    ['Rajaaha'       ] = { 0,   230, xi.guild.GOLDSMITHING, xi.skill.GOLDSMITHING, xi.effect.GOLDSMITHING_IMAGERY }, -- Dual
    ['Gidappa'       ] = { 0,   228, xi.guild.CLOTHCRAFT,   xi.skill.CLOTHCRAFT,   xi.effect.CLOTHCRAFT_IMAGERY   }, -- Dual
    ['Zwaluh'        ] = { 0,   226, xi.guild.LEATHERCRAFT, xi.skill.LEATHERCRAFT, xi.effect.LEATHERCRAFT_IMAGERY }, -- Dual
    ['Nudahaal'      ] = { 0,   224, xi.guild.BONECRAFT,    xi.skill.BONECRAFT,    xi.effect.BONECRAFT_IMAGERY    }, -- Dual
    ['Sulbahn'       ] = { 0,   636, xi.guild.ALCHEMY,      xi.skill.ALCHEMY,      xi.effect.ALCHEMY_IMAGERY      }, -- Advanced
    ['Hadayah'       ] = { 1,   638, xi.guild.ALCHEMY,      xi.skill.ALCHEMY,      xi.effect.ALCHEMY_IMAGERY      }, -- Free
    ['Shahau'        ] = { 2,   640, xi.guild.ALCHEMY,      xi.skill.ALCHEMY,      xi.effect.ALCHEMY_IMAGERY      }, -- Free
    ['Numaaf'        ] = { 0,   222, xi.guild.COOKING,      xi.skill.COOKING,      xi.effect.COOKING_IMAGERY      }, -- Dual
}

-- Give proper free image support power and duration.
local function freeImageSupport(player, effectId)
    player:delStatusEffectsByFlag(xi.effectFlag.SYNTH_SUPPORT, true)

    if effectId == xi.effect.FISHING_IMAGERY then
        player:addStatusEffect(effectId, 1, 0, 3600)
    else
        player:addStatusEffect(effectId, 1, 0, 120)
    end
end

-- Give proper advanced image support power and duration.
local function advancedImageSupport(player, effectId)
    player:delStatusEffectsByFlag(xi.effectFlag.SYNTH_SUPPORT, true)

    if effectId == xi.effect.FISHING_IMAGERY then
        player:addStatusEffect(effectId, 2, 0, 7200)
    else
        player:addStatusEffect(effectId, 3, 0, 480)
    end
end

-----------------------------------
-- Old Image Support NPCs
-----------------------------------
xi.crafting.oldImageSupportOnTrigger = function(player, npc)
    local npcName  = npc:getName()
    local skillId  = npcTable[npcName][4]
    local effectId = npcTable[npcName][5]

    -- Calculate parameters
    local eventId          = npcTable[npcName][2]
    local paramOne         = xi.crafting.getCraftSkillCap(player, skillId) -- Param 1 (Skill cap OR Gil Cost)
    local skillLevel       = xi.crafting.getRealSkill(player, skillId)     -- Param 2
    local messageParameter = npcTable[npcName][1]                          -- Param 3
    local guildsJoined     = player:getCharVar('Guild_Member')             -- Param 4
    local playerGil        = player:getGil()                               -- Param 5
    local imageDuration    = 0                                             -- Param 6

    -- Calculate gil cost if NPC gives advanced image support.
    if messageParameter == 0 then
        paramOne = (player:getSkillRank(skillId) + 1) * 30
    end

    -- Calculate effect Duration.
    if player:hasStatusEffect(effectId) then
        imageDuration = player:getStatusEffect(effectId):getDuration()
    end

    -- Event handles everything with correct params.
    player:startEvent(eventId, paramOne, skillLevel, messageParameter, guildsJoined, playerGil, imageDuration, 0, 0)
end

xi.crafting.oldImageSupportOnEventFinish = function(player, csid, option, npc)
    local ID               = zones[player:getZoneID()]
    local npcName          = npc:getName()
    local messageParameter = npcTable[npcName][1]
    local eventId          = npcTable[npcName][2]
    local guildId          = npcTable[npcName][3]
    local skillId          = npcTable[npcName][4]
    local effectId         = npcTable[npcName][5]
    local gilCost          = 0
    local joinedGuildMask  = player:getCharVar('Guild_Member')

    -- Handle advance support.
    if messageParameter == 0 then
        -- Calculate Gil cost.
        gilCost = (player:getSkillRank(skillId) + 1) * 30

        -- Handle special initial messages.
        if
            guildId == xi.guild.GOLDSMITHING and                          -- Goldsmithing guild.
            utils.mask.getBit(joinedGuildMask, xi.guild.GOLDSMITHING) and -- Has joined goldsnmithing guild.
            not utils.mask.getBit(joinedGuildMask, 24)                    -- Has not spoken to npc after joining guild.
        then
            player:incrementCharVar('Guild_Member', bit.lshift(1, 24))
        elseif
            guildId == xi.guild.ALCHEMY and                          -- Alchemy guild.
            utils.mask.getBit(joinedGuildMask, xi.guild.ALCHEMY) and -- Has joined alchemy guild.
            not utils.mask.getBit(joinedGuildMask, 25)               -- Has not spoken to npc after joining guild.
        then
            player:incrementCharVar('Guild_Member', bit.lshift(1, 25))
        end
    end

    -- Give status effect if aplicable.
    if csid == eventId and option == 1 and player:getGil() >= gilCost then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, guildId, messageParameter)

        if gilCost > 0 then
            player:delGil(gilCost)
            advancedImageSupport(player, effectId)
        else
            freeImageSupport(player, effectId)
        end
    end
end

-----------------------------------
-- Aht Uhrgan Image Support NPCs
-----------------------------------
xi.crafting.ahtUhrganImageSupportOnTrade = function(player, npc, trade)
    local ID       = zones[player:getZoneID()]
    local npcName  = npc:getName()
    local eventId  = npcTable[npcName][2] + 1 -- Trade event Id = Trigger event Id + 1
    local guildId  = npcTable[npcName][3]
    local effectId = npcTable[npcName][5]

    if xi.crafting.hasJoinedGuild(player, guildId) then
        if
            trade:hasItemQty(xi.item.IMPERIAL_BRONZE_PIECE, 1) and
            trade:getItemCount() == 1
        then
            if not player:hasStatusEffect(effectId) then
                player:tradeComplete()
                player:startEvent(eventId, 71, 0, 0, 0, 0, 0, guildId, xi.item.IMPERIAL_BRONZE_PIECE)
            else
                npc:showText(npc, ID.text.IMAGE_SUPPORT_ACTIVE)
            end
        end
    end
end

xi.crafting.ahtUhrganImageSupportOnTrigger = function(player, npc)
    local npcName  = npc:getName()
    local skillId  = npcTable[npcName][4]
    local effectId = npcTable[npcName][5]

    -- Calculate parameters
    local eventId          = npcTable[npcName][2]
    local dialogueOptions  = 8
    local skillLevel       = 0
    local messageParameter = npcTable[npcName][1]
    local guildsJoined     = player:getCharVar('Guild_Member')
    local imageDuration    = 0
    local guildId          = npcTable[npcName][3]

    -- Calculate dialogue options.
    if messageParameter > 0 then
        dialogueOptions = 4
    end

    -- Calculate skill level
    if xi.crafting.hasJoinedGuild(player, guildId) then
        skillLevel = xi.crafting.getRealSkill(player, skillId)
    end

    -- Calculate image support duration.
    if player:hasStatusEffect(effectId) then
        imageDuration = player:getStatusEffect(effectId):getDuration()
    end

    -- Event handles everything with correct params.
    player:startEvent(eventId, dialogueOptions, skillLevel, messageParameter, guildsJoined, 0, imageDuration, guildId, xi.item.IMPERIAL_BRONZE_PIECE)
end

xi.crafting.ahtUhrganImageSupportOnEventFinish = function(player, csid, option, npc)
    local ID       = zones[player:getZoneID()]
    local npcName  = npc:getName()
    local eventId  = npcTable[npcName][2]
    local guildId  = npcTable[npcName][3]
    local effectId = npcTable[npcName][5]

    -- Regular Image support.
    if csid == eventId and option == 1 then
        freeImageSupport(player, effectId)
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, guildId, 0)

    -- Advanced Image Support
    elseif csid == eventId + 1 then
        advancedImageSupport(player, effectId)
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, guildId, 1)
    end
end
