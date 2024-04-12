-----------------------------------
-- Image Support NPCs
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.crafting = {}

local npcTable =
{
    --    ['npc_name'] = { npc_number, guild_id,            skill_id,              effect_id,                aht_uhrgan_parameter_7,        aht_uhrgan_parameter_8 },
    ['Erabu-Fumulubu'] = { 1, 10012, xi.guild.FISHING,      xi.skill.FISHING,      xi.effect.FISHING_IMAGERY,                     0,                             0 },
    ['Degong'        ] = { 2, 10013, xi.guild.FISHING,      xi.skill.FISHING,      xi.effect.FISHING_IMAGERY,                     0,                             0 },
    ['Amarefice'     ] = { 1,   624, xi.guild.WOODWORKING,  xi.skill.WOODWORKING,  xi.effect.WOODWORKING_IMAGERY,                 0,                             0 },
    ['Ramua'         ] = { 2,   625, xi.guild.WOODWORKING,  xi.skill.WOODWORKING,  xi.effect.WOODWORKING_IMAGERY,                 0,                             0 },
    ['Hugues'        ] = { 1,   104, xi.guild.SMITHING,     xi.skill.SMITHING,     xi.effect.SMITHING_IMAGERY,                    0,                             0 },
    ['Romero'        ] = { 2,   105, xi.guild.SMITHING,     xi.skill.SMITHING,     xi.effect.SMITHING_IMAGERY,                    0,                             0 },
    ['Pinok-Morok'   ] = { 1,   629, xi.guild.SMITHING,     xi.skill.SMITHING,     xi.effect.SMITHING_IMAGERY,                    0,                             0 },
    ['Beadurinc'     ] = { 2,   630, xi.guild.SMITHING,     xi.skill.SMITHING,     xi.effect.SMITHING_IMAGERY,                    0,                             0 },
    ['Wulfnoth'      ] = { 1,   303, xi.guild.GOLDSMITHING, xi.skill.GOLDSMITHING, xi.effect.GOLDSMITHING_IMAGERY,                0,                             0 },
    ['Ulrike'        ] = { 2,   304, xi.guild.GOLDSMITHING, xi.skill.GOLDSMITHING, xi.effect.GOLDSMITHING_IMAGERY,                0,                             0 },
    ['Nikkoko'       ] = { 1, 10014, xi.guild.CLOTHCRAFT,   xi.skill.CLOTHCRAFT,   xi.effect.CLOTHCRAFT_IMAGERY,                  0,                             0 },
    ['Anillah'       ] = { 2, 10015, xi.guild.CLOTHCRAFT,   xi.skill.CLOTHCRAFT,   xi.effect.CLOTHCRAFT_IMAGERY,                  0,                             0 },
    ['Kipopo'        ] = { 1,   651, xi.guild.LEATHERCRAFT, xi.skill.LEATHERCRAFT, xi.effect.LEATHERCRAFT_IMAGERY,                0,                             0 },
    ['Tek_Lengyon'   ] = { 2,   652, xi.guild.LEATHERCRAFT, xi.skill.LEATHERCRAFT, xi.effect.LEATHERCRAFT_IMAGERY,                0,                             0 },
    ['Ronana'        ] = { 1, 10019, xi.guild.BONECRAFT,    xi.skill.BONECRAFT,    xi.effect.BONECRAFT_IMAGERY,                   0,                             0 },
    ['Kyaa_Taali'    ] = { 2, 10020, xi.guild.BONECRAFT,    xi.skill.BONECRAFT,    xi.effect.BONECRAFT_IMAGERY,                   0,                             0 },
    ['Titus'         ] = { 1,   123, xi.guild.ALCHEMY,      xi.skill.ALCHEMY,      xi.effect.ALCHEMY_IMAGERY,                     0,                             0 },
    ['Sieglinde'     ] = { 2,   124, xi.guild.ALCHEMY,      xi.skill.ALCHEMY,      xi.effect.ALCHEMY_IMAGERY,                     0,                             0 },
    ['Jacodaut'      ] = { 1, 10016, xi.guild.COOKING,      xi.skill.COOKING,      xi.effect.COOKING_IMAGERY,                     0,                             0 },
    ['Hakeem'        ] = { 2, 10017, xi.guild.COOKING,      xi.skill.COOKING,      xi.effect.COOKING_IMAGERY,                     0,                             0 },

    -- Aht Uhrgan npcs work diferently. Becouse of course they do.
    ['Hadayah'       ] = { 1,   638, xi.guild.ALCHEMY,      xi.skill.ALCHEMY,      xi.effect.ALCHEMY_IMAGERY,      xi.guild.ALCHEMY, xi.item.IMPERIAL_BRONZE_PIECE },
    ['Shahau'        ] = { 2,   640, xi.guild.ALCHEMY,      xi.skill.ALCHEMY,      xi.effect.ALCHEMY_IMAGERY,      xi.guild.ALCHEMY, xi.item.IMPERIAL_BRONZE_PIECE },
}

-----------------------------------
-- Free Image Support NPCs
-----------------------------------
xi.crafting.freeImageSupportOnTrigger = function(player, npc)
    local npcName  = npc:getName()
    local skillId  = npcTable[npcName][4]
    local effectId = npcTable[npcName][5]

    -- Calculate parameters
    local eventId          = npcTable[npcName][2]
    local skillCap         = xi.crafting.getCraftSkillCap(player, skillId)
    local skillLevel       = xi.crafting.getRealSkill(player, skillId)
    local messageParameter = npcTable[npcName][1]
    local guildsJoined     = player:getCharVar('Guild_Member')
    local playerGil        = player:getGil()
    local imageDuration    = 0
    local optionalGuildId  = npcTable[npcName][6] -- Aht Uhrgan only
    local itemRequired     = npcTable[npcName][7] -- Aht Uhrgan Only

    -- Calculate image support duration.
    local imageEffect = player:getStatusEffect(effectId)

    if player:hasStatusEffect(effectId) then
        imageDuration = imageEffect:getDuration()
    end

    -- Event handles everything with correct params.
    player:startEvent(eventId, skillCap, skillLevel, messageParameter, guildsJoined, playerGil, imageDuration, optionalGuildId, itemRequired)
end

xi.crafting.freeImageSupportOnEventFinish = function(player, csid, option, npc)
    local ID               = zones[player:getZoneID()]
    local npcName          = npc:getName()
    local messageParameter = npcTable[npcName][1]
    local eventId          = npcTable[npcName][2]
    local guildId          = npcTable[npcName][3]
    local effectId         = npcTable[npcName][5]

    if csid == eventId and option == 1 then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, guildId, messageParameter)
        player:delStatusEffectsByFlag(xi.effectFlag.SYNTH_SUPPORT, true)
        player:addStatusEffect(effectId, 1, 0, 120)
    end
end

-----------------------------------
-- Advanced Image Support NPCs
-----------------------------------

-----------------------------------
-- Free/Advanced Image Support NPCs
-----------------------------------
