-----------------------------------
-- Guild Masters
-----------------------------------
require('scripts/globals/hobbies/crafting/utils')
require('scripts/globals/npc_util')
-----------------------------------
xi = xi or {}
xi.crafting = xi.crafting or {}

-----------------------------------
-- Data
-----------------------------------
local lastRank = xi.craftRank.EXPERT

local npcTable =
{
    ['Thubu_Parohren'] = { 10009, xi.guild.FISHING,      xi.skill.FISHING,      xi.item.WATER_CRYSTAL, xi.keyItem.ANGLERS_ALMANAC,       '[Expert]Fishing'      },
    ['Cheupirudaux'  ] = {   621, xi.guild.WOODWORKING,  xi.skill.WOODWORKING,  xi.item.WIND_CRYSTAL,  xi.keyItem.WAY_OF_THE_CARPENTER,  '[Expert]Woodworking'  },
    ['Ghemp'         ] = {   101, xi.guild.SMITHING,     xi.skill.SMITHING,     xi.item.FIRE_CRYSTAL,  xi.keyItem.WAY_OF_THE_BLACKSMITH, '[Expert]Smithing'     },
    ['Mevreauche'    ] = {   626, xi.guild.SMITHING,     xi.skill.SMITHING,     xi.item.FIRE_CRYSTAL,  xi.keyItem.WAY_OF_THE_BLACKSMITH, '[Expert]Smithing'     },
    ['Reinberta'     ] = {   300, xi.guild.GOLDSMITHING, xi.skill.GOLDSMITHING, xi.item.FIRE_CRYSTAL,  xi.keyItem.WAY_OF_THE_GOLDSMITH,  '[Expert]Goldsmithing' },
    ['Ponono'        ] = { 10011, xi.guild.CLOTHCRAFT,   xi.skill.CLOTHCRAFT,   xi.item.EARTH_CRYSTAL, xi.keyItem.WAY_OF_THE_WEAVER,     '[Expert]Clothcraft'   },
    ['Faulpie'       ] = {   648, xi.guild.LEATHERCRAFT, xi.skill.LEATHERCRAFT, xi.item.DARK_CRYSTAL,  xi.keyItem.WAY_OF_THE_TANNER,     '[Expert]Leathercraft' },
    ['Peshi_Yohnts'  ] = { 10016, xi.guild.BONECRAFT,    xi.skill.BONECRAFT,    xi.item.WIND_CRYSTAL,  xi.keyItem.WAY_OF_THE_BONEWORKER, '[Expert]Bonecraft'    },
    ['Abd-al-Raziq'  ] = {   120, xi.guild.ALCHEMY,      xi.skill.ALCHEMY,      xi.item.WATER_CRYSTAL, xi.keyItem.WAY_OF_THE_ALCHEMIST,  '[Expert]Alchemy'      },
    ['Piketo-Puketo' ] = { 10013, xi.guild.COOKING,      xi.skill.COOKING,      xi.item.FIRE_CRYSTAL,  xi.keyItem.WAY_OF_THE_CULINARIAN, '[Expert]Cooking'      },
}

local testItemTable =
{
    [xi.guild.FISHING] =
    {
        xi.item.MOAT_CARP_1,
        xi.item.CHEVAL_SALMON,
        xi.item.GIANT_CATFISH_1,
        xi.item.GUGRU_TUNA_1,
        xi.item.MONKE_ONKE_1,
        xi.item.BHEFHEL_MARLIN_1,
        xi.item.BLADEFISH_1,
        xi.item.THREE_EYED_FISH_1,
        xi.item.GIGANT_SQUID,
        xi.item.TIGER_SHARK,
    },
    [xi.guild.WOODWORKING] =
    {
        xi.item.WORKBENCH,
        xi.item.MAPLE_TABLE,
        xi.item.HARP,
        xi.item.TRAVERSIERE,
        xi.item.ROSE_WAND,
        xi.item.KAMAN,
        xi.item.EBONY_WAND,
        xi.item.COMMODE,
        xi.item.MYTHIC_POLE,
        xi.item.VEJOVIS_WAND,
    },
    [xi.guild.SMITHING] =
    {
        xi.item.XIPHOS,
        xi.item.ASPIS,
        xi.item.BILBO,
        xi.item.WAR_PICK,
        xi.item.MYTHRIL_PICK,
        xi.item.DARKSTEEL_FALCHION,
        xi.item.BASCINET,
        xi.item.BASTARD_SWORD,
        xi.item.CELATA,
        xi.item.GORKHALI_KUKRI,
    },
    [xi.guild.GOLDSMITHING] =
    {
        xi.item.COPPER_HAIRPIN,
        xi.item.BRASS_HAIRPIN,
        xi.item.SILVER_HAIRPIN,
        xi.item.CHAIN_GORGET,
        xi.item.MYTHRIL_RING,
        xi.item.MYTHRIL_GORGET,
        xi.item.MYTHRIL_BREASTPLATE,
        xi.item.TORQUE,
        xi.item.COLICHEMARDE,
        xi.item.EVADER_EARRING,
    },
    [xi.guild.CLOTHCRAFT] =
    {
        xi.item.CAPE,
        xi.item.COTTON_CAPE,
        xi.item.HEKO_OBI,
        xi.item.FEATHER_COLLAR,
        xi.item.WOOL_BRACERS,
        xi.item.RED_CAPE,
        xi.item.WOOL_DOUBLET,
        xi.item.SILK_CLOAK,
        xi.item.ARHATS_HAKAMA,
        xi.item.SWITH_CAPE,
    },
    [xi.guild.LEATHERCRAFT] =
    {
        xi.item.RABBIT_MANTLE,
        xi.item.LIZARD_CESTI,
        xi.item.DHALMEL_MANTLE,
        xi.item.MAGIC_BELT,
        xi.item.CUIR_BOUILLI,
        xi.item.RAPTOR_JERKIN,
        xi.item.BATTLE_BOOTS,
        xi.item.TIGER_GLOVES,
        xi.item.COEURL_MASK,
        xi.item.URJA_TROUSERS,
    },
    [xi.guild.BONECRAFT] =
    {
        xi.item.SHELL_RING,
        xi.item.BONE_RING,
        xi.item.BEETLE_EARRING,
        xi.item.HORN_RING,
        xi.item.CARAPACE_GORGET,
        xi.item.ASTRAGALOS,
        xi.item.BONE_PATAS,
        xi.item.CORAL_HAIRPIN,
        xi.item.CORAL_BANGLES,
        xi.item.HAJDUK_RING,
    },
    [xi.guild.ALCHEMY] =
    {
        xi.item.BLOCK_OF_ANIMAL_GLUE,
        xi.item.FLASK_OF_POISON_POTION,
        xi.item.FLASK_OF_BLINDING_POTION,
        xi.item.JAR_OF_FIRESAND,
        xi.item.FIRE_SWORD,
        xi.item.HI_POTION,
        xi.item.ACID_KUKRI,
        xi.item.X_POTION,
        xi.item.BLOODY_SWORD,
        xi.item.SAIDA_RING,
    },
    [xi.guild.COOKING] =
    {
        xi.item.SALMON_SUB_SANDWICH,
        xi.item.BOWL_OF_PEA_SOUP,
        xi.item.BOWL_OF_VEGETABLE_GRUEL,
        xi.item.MEAT_MITHKABOB,
        xi.item.APPLE_PIE,
        xi.item.BOTTLE_OF_YAGUDO_DRINK,
        xi.item.PIECE_OF_RAISIN_BREAD,
        xi.item.BOWL_OF_WHITEFISH_STEW,
        xi.item.BOWL_OF_SEAFOOD_STEW,
        xi.item.BOWL_OF_SPRIGHTLY_SOUP,
    },
}

local function giveNewRank(player, skillId, newRank)
    -- Raise rank.
    player:setSkillRank(skillId, newRank)

    -- Set local var to complete trade after event.
    player:setLocalVar('CompleteTrade', 1)
end

-----------------------------------
-- NPC Functions
-----------------------------------
xi.crafting.guildMasterOnTrade = function(player, npc, trade)
    local npcName = npc:getName()
    local eventId = npcTable[npcName][1] + 1 -- Trade event = Trigger event + 1
    local guildId = npcTable[npcName][2]
    local skillId = npcTable[npcName][3]

    -- Get test item and new rank.
    local newRank    = player:getSkillRank(skillId) + 1
    local testItem   = 0
    local skillLevel = xi.crafting.getRealSkill(player, skillId)
    local skillCap   = xi.crafting.getCraftSkillCap(player, skillId)

    if
        skillLevel >= skillCap - 2 and
        newRank <= lastRank
    then
        testItem = testItemTable[guildId][newRank]
    end

    -- Check trade.
    if
        testItem ~= 0 and
        trade:hasItemQty(testItem, 1) and
        trade:getItemCount() == 1
    then
        -- Expert quest.
        if
            newRank == xi.craftRank.EXPERT and           -- Check if new rank is the last one. (Tied to mini-quest)
            player:hasKeyItem(npcTable[npcName][5]) and  -- Check if player has appropiate Key Item.
            player:getCharVar(npcTable[npcName][6]) == 2 -- Check if player has gotten quest dialog.
        then
            if
                (guildId ~= xi.guild.FISHING and trade:getItem():getSignature() == player:getName()) or
                guildId == xi.guild.FISHING
            then
                player:setCharVar(npcTable[npcName][6], 0)
                giveNewRank(player, skillId, newRank)
                player:startEvent(eventId, 0, 0, 0, 0, newRank, 1)
            else
                player:startEvent(eventId, 0, 0, 0, 0, newRank, 0)
            end

        -- All other ranks.
        elseif
            newRank > xi.craftRank.AMATEUR and
            newRank < lastRank
        then
            giveNewRank(player, skillId, newRank)
            player:startEvent(eventId, 0, 0, 0, 0, newRank, 0)
        end
    end
end

-- Crafts at or above the common cap rank, except the highest one, which cannot be renounced
local function getRenounceableCrafts(player)
    local rankFromSetting   = math.floor(xi.settings.map.CRAFT_COMMON_CAP / 100)
    local highestSkillId    = 0
    local highestSkillLevel = 0

    for skillChecked = xi.skill.WOODWORKING, xi.skill.COOKING do
        local currentSkillLevel = player:getCharSkillLevel(skillChecked)

        if currentSkillLevel > highestSkillLevel then
            highestSkillLevel = currentSkillLevel
            highestSkillId    = skillChecked
        end
    end

    local renounceable = {}

    for skillChecked = xi.skill.WOODWORKING, xi.skill.COOKING do
        if
            player:getSkillRank(skillChecked) >= rankFromSetting and
            skillChecked ~= highestSkillId
        then
            renounceable[skillChecked] = true
        end
    end

    return renounceable
end

xi.crafting.guildMasterOnTrigger = function(player, npc)
    local npcName  = npc:getName()
    local eventId  = npcTable[npcName][1]
    local guildId  = npcTable[npcName][2]
    local skillId  = npcTable[npcName][3]
    local keyItem  = npcTable[npcName][5]
    local nextRank = player:getSkillRank(skillId) + 1

    -- Event parameters
    local testItem       = GetSystemTime()                                     -- Parameter 1: Current time OR Test Item if applicable.
    local skillLevel     = xi.crafting.getRealSkill(player, skillId)     -- Parameter 2: Player real level on concrete craft.
    local skillCap       = xi.crafting.getCraftSkillCap(player, skillId) -- Parameter 3: Player max level on concrete craft.
    local guildsJoined   = player:getCharVar('Guild_Member')             -- Parameter 4: Bitmask with guilds joined.
    local questStatus    = 0                                             -- Parameter 5: Used for expert quest.
    local artisanCount   = 0                                             -- Parameter 7: Number of crafts at Artisan rank or higher.
    local artisanBitmask = 0                                             -- Parameter 8: Bitmask of craft guilds at Artisan rank or higher.

    -- Calculate parameter 1 (Test item)
    if
        skillLevel >= skillCap - 2 and
        nextRank <= lastRank
    then
        testItem = testItemTable[guildId][nextRank]
    end

    -- Calculate parameter 5 (Quest status)
    local questVar = player:getCharVar(npcTable[npcName][6])

    if questVar > 0 then
        questStatus = bit.lshift(1, 9) -- Set bit 9 (Quest accepted)

        if player:hasKeyItem(keyItem) then
            questStatus = questStatus + bit.lshift(1, guildId) -- Set KI bit (Item revealed) (It happens to be the same bit as guild bit)
        end

        if questVar == 2 then
            questStatus = questStatus + bit.lshift(1, 10) -- Set bit 10 (Item reminder)
        end
    end

    -- Calculate parameters 7 and 8 (Used for rank renouncement)
    -- Note 1: It cycles. First time returns params. Second doesnt. Third does. And so on.
    -- Note 2: Highest level craft cannot be renounced.
    if
        xi.crafting.hasJoinedGuild(player, guildId) and
        guildId ~= xi.guild.FISHING
    then
        if player:getLocalVar('skipRenounceDialog') == 0 then
            local rankFromSetting = math.floor(xi.settings.map.CRAFT_COMMON_CAP / 100) -- If 700, it will return rank 7 (Artisan)
            local renounceable    = getRenounceableCrafts(player)

            -- Params 7 and 8.
            for skillChecked = xi.skill.WOODWORKING, xi.skill.COOKING do
                -- Param 7: Count crafts over craftsman rank.
                if player:getSkillRank(skillChecked) >= rankFromSetting then
                    artisanCount = artisanCount + 1
                end

                -- Param 8: Full mask except craft ids that CAN be renounced.
                if not renounceable[skillChecked] then
                    artisanBitmask = bit.bor(artisanBitmask, bit.lshift(1, skillChecked - 48))
                end
            end

            player:setLocalVar('skipRenounceDialog', 1)
        else
            player:setLocalVar('skipRenounceDialog', 0)
        end
    end

    player:startEvent(eventId, testItem, skillLevel, skillCap, guildsJoined, questStatus, 0, artisanCount, artisanBitmask)
end

xi.crafting.guildMasterOnEventFinish = function(player, csid, option, npc)
    local ID      = zones[player:getZoneID()]
    local npcName = npc:getName()
    local eventId = npcTable[npcName][1]
    local guildId = npcTable[npcName][2]

    -- Trigger onEventFinish
    if csid == eventId then

        -- Signup Event.
        if option == 1 then
            local crystalId = npcTable[npcName][4] -- Crystal

            if player:getFreeSlotsCount() == 0 then
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, crystalId)
            else
                player:messageSpecial(ID.text.ITEM_OBTAINED, crystalId)
                player:addItem(crystalId)
                player:incrementCharVar('Guild_Member', bit.lshift(1, guildId))
            end

        -- Expert quest: Start.
        elseif option == 2 then
            if xi.crafting.hasJoinedGuild(player, guildId) then
                if player:getCharVar(npcTable[npcName][6]) == 0 then
                    player:setCharVar(npcTable[npcName][6], 1)
                end
            end

        -- Expert quest ready for trade (after getting KI)
        elseif option == 3 then
            player:setCharVar(npcTable[npcName][6], 2)

        -- Rank renouncement.
        elseif
            option >= xi.skill.WOODWORKING and
            option <= xi.skill.COOKING and
            xi.crafting.hasJoinedGuild(player, guildId) and
            guildId ~= xi.guild.FISHING and
            getRenounceableCrafts(player)[option]
        then
            local rankFromSetting = math.floor(xi.settings.map.CRAFT_COMMON_CAP / 100) - 1 -- If 700, it will return rank 6 (Craftsman)

            player:setSkillRank(option, rankFromSetting)
            player:setSkillLevel(option, xi.settings.map.CRAFT_COMMON_CAP)

            player:messageSpecial(ID.text.RENOUNCE_CRAFTSMAN, 0, option - 49)
        end

    -- Trade onEventFinish
    elseif csid == eventId + 1 then
        if player:getLocalVar('CompleteTrade') == 1 then
            player:tradeComplete()
            player:setLocalVar('CompleteTrade', 0)
        end
    end

    -- Handle RoE.
    if guildId ~= xi.guild.FISHING then
        local recordId = guildId + 99

        if player:hasEminenceRecord(recordId) then
            xi.roe.onRecordTrigger(player, recordId)
        end
    end
end
