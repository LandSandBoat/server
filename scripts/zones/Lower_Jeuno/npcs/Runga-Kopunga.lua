-----------------------------------
-- Area: Lower Jeuno
-- NPC: Runga-Kopunga
-----------------------------------
local ID = zones[xi.zone.LOWER_JEUNO]
-----------------------------------
---@type TNpcEntity
local entity = {}

-- Ring/Earring exchange mappings
local accessoryExchange = {
    -- DM Earring Cycle
    [xi.item.SUPPANOMIMI]     = xi.item.BUSHINOMIMI,
    [xi.item.BUSHINOMIMI]     = xi.item.BEASTLY_EARRING,
    [xi.item.BEASTLY_EARRING] = xi.item.KNIGHTS_EARRING,
    [xi.item.KNIGHTS_EARRING] = xi.item.ABYSSAL_EARRING,
    [xi.item.ABYSSAL_EARRING] = xi.item.SUPPANOMIMI,

    -- CoP Ring Cycle
    [xi.item.RAJAS_RING]  = xi.item.TAMAS_RING,
    [xi.item.TAMAS_RING]  = xi.item.SATTVA_RING,
    [xi.item.SATTVA_RING] = xi.item.RAJAS_RING,

    -- Apoc Nigh Earring Cycle
    [xi.item.STATIC_EARRING]   = xi.item.MAGNETIC_EARRING,
    [xi.item.MAGNETIC_EARRING] = xi.item.HOLLOW_EARRING,
    [xi.item.HOLLOW_EARRING]   = xi.item.ETHEREAL_EARRING,
    [xi.item.ETHEREAL_EARRING] = xi.item.STATIC_EARRING,

    -- ToAU Ring Cycle
    [xi.item.BALRAHNS_RING] = xi.item.ULTHALAMS_RING,
    [xi.item.ULTHALAMS_RING] = xi.item.JALZAHNS_RING,
    [xi.item.JALZAHNS_RING] = xi.item.BALRAHNS_RING,
}

local augments = {
    [xi.item.RIDILL] = {
        eggs = {
            {
                egg = xi.item.S_EGG,
                slots = {
                    {
                        { weight = 1, id = xi.augment.ATTACK_P1, minValue = 0, maxValue = 9, desc = "Attack+%d" },
                    }
                }
            },
            {
                egg = xi.item.D_EGG,
                slots = {
                    {
                        { weight = 89, id = xi.augment.DMG_P1, minValue = 4, maxValue = 14, desc = "DMG+%d" },
                        { weight = 10, id = xi.augment.DMG_P1, minValue = 15, maxValue = 18, desc = "DMG+%d (Near Max!)" },
                        { weight = 1, id = xi.augment.DMG_P1, minValue = 19, maxValue = 19, desc = "DMG+%d (MAX!)" },
                    }
                }
            }
        }
    },
    [xi.item.KRAKEN_CLUB] = {
        eggs = {
            {
                egg = xi.item.S_EGG,
                slots = {
                    {
                        { weight = 1, id = xi.augment.ATTACK_P1, minValue = 0, maxValue = 9, desc = "Attack+%d" },
                    }
                }
            },
            {
                egg = xi.item.D_EGG,
                slots = {
                    {
                        { weight = 89, id = xi.augment.DMG_P1, minValue = 4, maxValue = 14, desc = "DMG+%d" },
                        { weight = 10, id = xi.augment.DMG_P1, minValue = 15, maxValue = 18, desc = "DMG+%d (Near Max!)" },
                        { weight = 1, id = xi.augment.DMG_P1, minValue = 19, maxValue = 19, desc = "DMG+%d (MAX!)" },
                    }
                }
            }
        }
    },
    [xi.item.JOYEUSE] = {
        eggs = {
            {
                egg = xi.item.D_EGG,
                slots = {
                    {
                        { weight = 89, id = xi.augment.DMG_P1, minValue = 4, maxValue = 14, desc = "DMG+%d" },
                        { weight = 10, id = xi.augment.DMG_P1, minValue = 15, maxValue = 18, desc = "DMG+%d (Near Max!)" },
                        { weight = 1, id = xi.augment.DMG_P1, minValue = 19, maxValue = 19, desc = "DMG+%d (MAX!)" },
                    }
                }
            }
        }
    },
    [xi.item.MERCURIAL_KRIS] = {
        eggs = {
            {
                egg = xi.item.D_EGG,
                slots = {
                    {
                        { weight = 89, id = xi.augment.DMG_P1, minValue = 4, maxValue = 14, desc = "DMG+%d" },
                        { weight = 10, id = xi.augment.DMG_P1, minValue = 15, maxValue = 18, desc = "DMG+%d (Near Max!)" },
                        { weight = 1, id = xi.augment.DMG_P1, minValue = 19, maxValue = 19, desc = "DMG+%d (MAX!)" },
                    }
                }
            }
        }
    },
    [xi.item.CHATOYANT_STAFF] = {
        eggs = {
            {
                egg = xi.item.M_EGG,
                slots = {
                    {
                        { weight = 1, id = 288, minValue = 0, maxValue = 4, desc = "Divine Magic Skill+%d" },
                        { weight = 1, id = 289, minValue = 0, maxValue = 4, desc = "Healing Magic Skill+%d" },
                        { weight = 1, id = 290, minValue = 0, maxValue = 4, desc = "Enhancing Magic Skill+%d" },
                        { weight = 1, id = 291, minValue = 0, maxValue = 4, desc = "Enfeebling Magic Skill+%d" },
                        { weight = 1, id = 292, minValue = 0, maxValue = 4, desc = "Elemental Magic Skill+%d" },
                        { weight = 1, id = 293, minValue = 0, maxValue = 4, desc = "Dark Magic Skill+%d" },
                        { weight = 1, id = 294, minValue = 0, maxValue = 4, desc = "Summoning Magic Skill+%d" },
                        { weight = 1, id = 295, minValue = 0, maxValue = 4, desc = "Ninjutsu Skill+%d" },
                        { weight = 1, id = 296, minValue = 0, maxValue = 4, desc = "Singing Skill+%d" },
                        { weight = 1, id = 297, minValue = 0, maxValue = 4, desc = "String Instrument Skill+%d" },
                        { weight = 1, id = 298, minValue = 0, maxValue = 4, desc = "Wind Instrument Skill+%d" },
                        { weight = 1, id = 299, minValue = 0, maxValue = 4, desc = "Blue Magic Skill+%d" },
                    },
                    {
                        { weight = 1, id = 288, minValue = 0, maxValue = 4, desc = "Divine Magic Skill+%d" },
                        { weight = 1, id = 289, minValue = 0, maxValue = 4, desc = "Healing Magic Skill+%d" },
                        { weight = 1, id = 290, minValue = 0, maxValue = 4, desc = "Enhancing Magic Skill+%d" },
                        { weight = 1, id = 291, minValue = 0, maxValue = 4, desc = "Enfeebling Magic Skill+%d" },
                        { weight = 1, id = 292, minValue = 0, maxValue = 4, desc = "Elemental Magic Skill+%d" },
                        { weight = 1, id = 293, minValue = 0, maxValue = 4, desc = "Dark Magic Skill+%d" },
                        { weight = 1, id = 294, minValue = 0, maxValue = 4, desc = "Summoning Magic Skill+%d" },
                        { weight = 1, id = 295, minValue = 0, maxValue = 4, desc = "Ninjutsu Skill+%d" },
                        { weight = 1, id = 296, minValue = 0, maxValue = 4, desc = "Singing Skill+%d" },
                        { weight = 1, id = 297, minValue = 0, maxValue = 4, desc = "String Instrument Skill+%d" },
                        { weight = 1, id = 298, minValue = 0, maxValue = 4, desc = "Wind Instrument Skill+%d" },
                        { weight = 1, id = 299, minValue = 0, maxValue = 4, desc = "Blue Magic Skill+%d" },
                    }
                }
            }
        }
    },
    [xi.item.SCORPION_HARNESS_P1] = {
        eggs = {
            {
                egg = xi.item.H_EGG,
                slots = {
                    {
                        { weight = 1, id = xi.augment.HP_P1, minValue = 0, maxValue = 9, desc = "HP+%d" },
                        { weight = 1, id = xi.augment.ATTACK_P1, minValue = 0, maxValue = 9, desc = "Attack+%d" },
                        { weight = 1, id = xi.augment.RAPID_SHOT_P1, minValue = 0, maxValue = 9, desc = "Rapid Shot+%d" },
                        { weight = 1, id = xi.augment.HASTE_P1, minValue = 0, maxValue = 0, desc = "Haste+1%%" },
                        { weight = 1, id = xi.augment.ACCURACY_P1, minValue = 0, maxValue = 9, desc = "Accuracy+%d" },
                    }
                }
            }
        }
    },
}

-- Helper function to roll augments
local function rollAugments(itemID, eggID)
    local itemEntry = augments[itemID]
    if not itemEntry then return nil end
    
    -- Find the right egg
    local eggConfig = nil
    for _, config in ipairs(itemEntry.eggs) do
        if config.egg == eggID then
            eggConfig = config
            break
        end
    end
    
    if not eggConfig then return nil end
    
    local slots = {}
    local descriptions = {}
    
    for slotIndex, slot in ipairs(eggConfig.slots) do
        local totalWeight = 0
        for _, augment in ipairs(slot) do
            totalWeight = totalWeight + augment.weight
        end
        
        local roll = math.random(1, totalWeight)
        
        for _, augment in ipairs(slot) do
            if roll <= augment.weight then
                slots[slotIndex] = { id = augment.id }
                
                if augment.maxValue > augment.minValue then
                    slots[slotIndex].value = math.random(augment.minValue, augment.maxValue)
                else
                    slots[slotIndex].value = augment.maxValue
                end
                
                -- Generate description
                if augment.desc then
                    local value = slots[slotIndex].value + 1
                    if augment.desc:find("%%d") then
                        descriptions[slotIndex] = string.format(augment.desc, value)
                    else
                        descriptions[slotIndex] = augment.desc
                    end
                end
                
                break
            end
            roll = roll - augment.weight
        end
    end
    
    return slots, descriptions
end

entity.onTrade = function(player, npc, trade)
    -- Check for ring/earring exchanges first
    for inputItem, outputItem in pairs(accessoryExchange) do
        if npcUtil.tradeHasExactly(trade, inputItem) then
            if player:getFreeSlotsCount() > 0 and player:hasKeyItem(xi.ki.FAIL_BADGE) then
                player:confirmTrade()
                player:addItem(outputItem, 1)
                player:messageSpecial(ID.text.ITEM_OBTAINED, outputItem)
            else
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, outputItem)
            end
            return
        end
    end
    
    -- Check for augment trades
    local eggTypes = {xi.item.S_EGG, xi.item.D_EGG, xi.item.H_EGG, xi.item.M_EGG}
    
    for itemID, itemConfig in pairs(augments) do
        for _, eggID in ipairs(eggTypes) do
            if npcUtil.tradeHasExactly(trade, {itemID, eggID}) then
                local slots, descriptions = rollAugments(itemID, eggID)
                
                if slots then
                    player:confirmTrade()
                    
                    -- Add item with augments
                    if #slots == 1 then
                        player:addItem(itemID, 1, slots[1].id, slots[1].value)
                    elseif #slots == 2 then
                        player:addItem(itemID, 1, slots[1].id, slots[1].value, slots[2].id, slots[2].value)
                    end
                    
                    local itemName = "your item"
                    if itemID == xi.item.RIDILL then itemName = "your Ridill"
                    elseif itemID == xi.item.KRAKEN_CLUB then itemName = "your Kraken Club"
                    elseif itemID == xi.item.JOYEUSE then itemName = "your Joyeuse"
                    elseif itemID == xi.item.MERCURIAL_KRIS then itemName = "your Mercurial Kris"
                    elseif itemID == xi.item.CHATOYANT_STAFF then itemName = "your Chatoyant Staff"
                    elseif itemID == xi.item.SCORPION_HARNESS_P1 then itemName = "your Scorpion Harness"
                    end
                    
                    local descMessage = table.concat(descriptions, " and ")
                    player:printToPlayer(string.format("You have successfully augmented %s with %s", itemName, descMessage), xi.msg.channel.SYSTEM_3)
                    player:printToPlayer("To examine the augment, highlight item and press minus key on numpad", xi.msg.channel.SYSTEM_3)
                end
                return
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    player:printToPlayer("Trade Ridill & S egg for an augmented attack+ Ridill (Random chance for value)", xi.msg.channel.SAY, "Runga-Kopunga")
    player:printToPlayer("Trade Scorpion Harness +1 & H egg for an augmented Scorpion Harness+1 (Random chance for augtype & value)", xi.msg.channel.SAY, "Runga-Kopunga")
    player:printToPlayer("Trade Select Weapons & D egg for an augmented DMG (Random chance for value)", xi.msg.channel.SAY, "Runga-Kopunga")
    player:printToPlayer("Trade Chatoyant Staff & M egg for augmented Magic Skills (Random chance for value)", xi.msg.channel.SAY, "Runga-Kopunga")

    local stock = {
        {xi.item.G_EGG, 166666},
        {xi.item.V_EGG, 500000},
        {xi.item.J_EGG, 500000},
        {xi.item.H_EGG, 250000},
        {xi.item.M_EGG, 350000},
        {xi.item.S_EGG, 1000000},
        {xi.item.D_EGG, 10000000},
    }

    xi.shop.general(player, stock)
end

return entity
