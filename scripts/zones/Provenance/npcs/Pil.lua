-----------------------------------
-- Pil
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- Augment removal code
    local items = {
        xi.item.TOREADORS_RING,
        xi.item.ROSE_STRAP,
        xi.item.VELOCIOUS_BELT,
        xi.item.LOQUACIOUS_EARRING,
        xi.item.BRUTAL_EARRING,
        xi.item.PRISM_CAPE,
        xi.item.WALAHRA_TURBAN,
        xi.item.HAUBERGEON_P1,
        xi.item.BIBIKI_SEASHELL
    }

    for _, k in pairs(items) do
        if npcUtil.tradeHasExactly(trade, {k, {"gil", 50000}}) then
            player:confirmTrade()
            player:delGil(50000)
            npcUtil.giveItem(player, k)
            break
        end
    end
    
    -- Toreador's Ring augments
    if npcUtil.tradeHasExactly(trade, {xi.item.TOREADORS_RING, xi.item.V_EGG}) then
        local roll1 = math.random(0, 20)
        local roll2 = math.random(0, 20)
        
        local aug1, val1, aug2, val2
        local desc1, desc2 = "", ""
        
        -- Determine first augment
        if roll1 == 20 then
            aug1 = xi.augment.CRITICAL_HIT_RATE_P1
            val1 = math.random(0, 1)
            desc1 = "Crit Rate+" .. (val1 + 1)
        elseif roll1 == 19 then
            aug1 = xi.augment.CRITICAL_HIT_DAMAGE_P1
            val1 = math.random(0, 4)
            desc1 = "Crit Dmg+" .. (val1 + 1) .. "%"
        elseif roll1 == 18 then
            aug1 = xi.augment.CRITICAL_HIT_RATE_P1
            val1 = math.random(0, 2)
            desc1 = "Crit Rate+" .. (val1 + 1)
        elseif roll1 == 17 then
            aug1 = xi.augment.RNG_ATK_P1
            val1 = math.random(0, 6)
            desc1 = "R.Atk+" .. (val1 + 1)
        elseif roll1 == 16 then
            aug1 = xi.augment.RNG_ACC_P1
            val1 = math.random(0, 12)
            desc1 = "R.Acc+" .. (val1 + 1)
        elseif roll1 == 15 then
            aug1 = xi.augment.TRIPLE_ATTACK_P1
            val1 = math.random(0, 1)
            desc1 = "Triple Attack+" .. (val1 + 1) .. "%"
        elseif roll1 == 14 then
            aug1 = xi.augment.ENMITY_P1
            val1 = math.random(0, 4)
            desc1 = "Enmity+" .. (val1 + 1)
        elseif roll1 == 13 then
            aug1 = xi.augment.ENMITY_M1
            val1 = math.random(0, 4)
            desc1 = "Enmity-" .. (val1 + 1)
        elseif roll1 == 12 then
            aug1 = xi.augment.ACCURACY_P1
            val1 = math.random(0, 4)
            desc1 = "Acc+" .. (val1 + 1)
        elseif roll1 == 11 then
            aug1 = xi.augment.ACCURACY_M1
            val1 = math.random(0, 4)
            desc1 = "Acc-" .. (val1 + 1)
        elseif roll1 == 10 then
            aug1 = xi.augment.ATTACK_P1
            val1 = math.random(0, 4)
            desc1 = "Attack+" .. (val1 + 1)
        elseif roll1 == 9 then
            aug1 = xi.augment.ATTACK_M1
            val1 = math.random(0, 4)
            desc1 = "Attack-" .. (val1 + 1)
        elseif roll1 >= 6 and roll1 <= 8 then
            aug1 = math.random(xi.augment.STR_P1, xi.augment.CHR_M1)
            val1 = math.random(0, 2)
            if aug1 <= xi.augment.CHR_P1 then
                local stats = {"STR", "DEX", "VIT", "AGI", "INT", "MND", "CHR"}
                desc1 = stats[aug1 - xi.augment.STR_P1 + 1] .. "+" .. (val1 + 1)
            else
                local stats = {"STR", "DEX", "VIT", "AGI", "INT", "MND", "CHR"}
                desc1 = stats[aug1 - xi.augment.STR_M1 + 1] .. "-" .. (val1 + 1)
            end
        else
            aug1 = math.random(xi.augment.FIRE_RESIST_P1, xi.augment.DARK_RESIST_M1)
            val1 = math.random(0, 11)
            local resists = {"Fire", "Ice", "Wind", "Earth", "Lightning", "Water", "Light", "Dark"}
            if aug1 <= xi.augment.DARK_RESIST_P1 then
                desc1 = resists[aug1 - xi.augment.FIRE_RESIST_P1 + 1] .. " Resist+" .. (val1 + 1)
            else
                desc1 = resists[aug1 - xi.augment.FIRE_RESIST_M1 + 1] .. " Resist-" .. (val1 + 1)
            end
        end
        
        -- Determine second augment
        if roll2 == 20 and roll1 == 20 then
            -- Special case: both rolled 20 (would need custom augment ID)
            aug2 = 1080  -- This would need to be added to the augments enum ?
            val2 = 0
        elseif roll2 >= 20 then
            aug2 = math.random(xi.augment.STR_P1, xi.augment.CHR_M1)
            val2 = math.random(0, 2)
            if aug2 <= xi.augment.CHR_P1 then
                local stats = {"STR", "DEX", "VIT", "AGI", "INT", "MND", "CHR"}
                desc2 = stats[aug2 - xi.augment.STR_P1 + 1] .. "+" .. (val2 + 1)
            else
                local stats = {"STR", "DEX", "VIT", "AGI", "INT", "MND", "CHR"}
                desc2 = stats[aug2 - xi.augment.STR_M1 + 1] .. "-" .. (val2 + 1)
            end
        elseif roll2 == 19 then
            aug2 = xi.augment.CRITICAL_HIT_DAMAGE_P1
            val2 = math.random(0, 4)
            desc2 = "Crit Dmg+" .. (val2 + 1) .. "%"
        elseif roll2 == 18 then
            aug2 = xi.augment.CRITICAL_HIT_RATE_P1
            val2 = math.random(0, 2)
            desc2 = "Crit Rate+" .. (val2 + 1)
        elseif roll2 == 17 then
            aug2 = xi.augment.RNG_ATK_P1
            val2 = math.random(0, 6)
            desc2 = "R.Atk+" .. (val2 + 1)
        elseif roll2 == 16 then
            aug2 = xi.augment.RNG_ACC_P1
            val2 = math.random(0, 12)
            desc2 = "R.Acc+" .. (val2 + 1)
        elseif roll2 == 15 then
            aug2 = xi.augment.TRIPLE_ATTACK_P1
            val2 = math.random(0, 1)
            desc2 = "Triple Attack+" .. (val2 + 1) .. "%"
        elseif roll2 == 14 then
            aug2 = xi.augment.ENMITY_P1
            val2 = math.random(0, 4)
            desc2 = "Enmity+" .. (val2 + 1)
        elseif roll2 == 13 then
            aug2 = xi.augment.ENMITY_M1
            val2 = math.random(0, 4)
            desc2 = "Enmity-" .. (val2 + 1)
        elseif roll2 == 12 then
            aug2 = xi.augment.ACCURACY_P1
            val2 = math.random(0, 4)
            desc2 = "Acc+" .. (val2 + 1)
        elseif roll2 == 11 then
            aug2 = xi.augment.ACCURACY_M1
            val2 = math.random(0, 4)
            desc2 = "Acc-" .. (val2 + 1)
        elseif roll2 == 10 then
            aug2 = xi.augment.ATTACK_P1
            val2 = math.random(0, 4)
            desc2 = "Attack+" .. (val2 + 1)
        elseif roll2 == 9 then
            aug2 = xi.augment.ATTACK_M1
            val2 = math.random(0, 4)
            desc2 = "Attack-" .. (val2 + 1)
        elseif roll2 >= 6 and roll2 <= 8 then
            aug2 = math.random(xi.augment.STR_P1, xi.augment.CHR_M1)
            val2 = math.random(0, 2)
            if aug2 <= xi.augment.CHR_P1 then
                local stats = {"STR", "DEX", "VIT", "AGI", "INT", "MND", "CHR"}
                desc2 = stats[aug2 - xi.augment.STR_P1 + 1] .. "+" .. (val2 + 1)
            else
                local stats = {"STR", "DEX", "VIT", "AGI", "INT", "MND", "CHR"}
                desc2 = stats[aug2 - xi.augment.STR_M1 + 1] .. "-" .. (val2 + 1)
            end
        else
            aug2 = math.random(xi.augment.FIRE_RESIST_P1, xi.augment.DARK_RESIST_M1)
            val2 = math.random(0, 11)
            local resists = {"Fire", "Ice", "Wind", "Earth", "Lightning", "Water", "Light", "Dark"}
            if aug2 <= xi.augment.DARK_RESIST_P1 then
                desc2 = resists[aug2 - xi.augment.FIRE_RESIST_P1 + 1] .. " Resist+" .. (val2 + 1)
            else
                desc2 = resists[aug2 - xi.augment.FIRE_RESIST_M1 + 1] .. " Resist-" .. (val2 + 1)
            end
        end
        
        player:tradeComplete()
        player:addItem(xi.item.TOREADORS_RING, 1, aug1, val1, aug2, val2)
        player:printToPlayer("You have successfully augmented your Toreador's Ring with " .. desc1 .. " and " .. desc2, xi.msg.channel.SYSTEM_3)
        player:printToPlayer("To examine the augment, highlight item and press minus key on numpad", xi.msg.channel.SYSTEM_3)
    
    -- Rose Strap augments
    elseif npcUtil.tradeHasExactly(trade, {xi.item.ROSE_STRAP, xi.item.V_EGG}) or
           npcUtil.tradeHasExactly(trade, {xi.item.ROSE_STRAP, xi.item.J_EGG}) then
        local aug1, val1, aug2, val2
        local desc1, desc2 = "", ""
        
        -- First augment
        local roll1 = math.random(0, 10)
        if roll1 == 10 then
            aug1 = xi.augment.STORE_TP_P1_SUBTLE_BLOW_P1
            val1 = math.random(1, 3)
            desc1 = "Store TP/Subtle Blow+" .. (val1 + 1)
        elseif roll1 == 9 then
            aug1 = xi.augment.ACCURACY_P1
            val1 = math.random(1, 3) * math.random(1, 2)
            desc1 = "Accuracy+" .. (val1 + 1)
        elseif roll1 == 8 then
            aug1 = xi.augment.ZANSHIN_P1
            val1 = 1
            desc1 = "Zanshin+" .. (val1 + 1)
        elseif roll1 >= 2 and roll1 <= 7 then
            -- Weapon skills
            local skills = {
                xi.augment.GREAT_SWORD_SKILL_P1,
                xi.augment.GREAT_AXE_SKILL_P1,
                xi.augment.SCYTHE_SKILL_P1,
                xi.augment.POLEARM_SKILL_P1,
                xi.augment.GREAT_KATANA_SKILL_P1,
                xi.augment.STAFF_SKILL_P1
            }
            local skillNames = {
                "Great Sword",
                "Great Axe",
                "Scythe",
                "Polearm",
                "Great Katana",
                "Staff"
            }
            aug1 = skills[roll1 - 1]
            val1 = math.random(1, 3)
            desc1 = skillNames[roll1 - 1] .. "+" .. (val1 + 1)
        else
            -- Resist
            if math.random(1, 2) == 1 then
                aug1 = xi.augment.RESIST_BLIND_P1
                val1 = 3 * math.random(1, 3)
                desc1 = "Resist Blind+" .. (val1 + 1)
            else
                aug1 = xi.augment.RESIST_PARALYZE_P1
                val1 = 3 * math.random(1, 3)
                desc1 = "Resist Paralyze+" .. (val1 + 1)
            end
        end
        
        -- Second augment
        local roll2 = math.random(1, 3)
        if roll2 == 3 then
            aug2 = xi.augment.STORE_TP_P1_SUBTLE_BLOW_P1
            val2 = math.random(1, 3)
            desc2 = "Store TP/Subtle Blow+" .. (val2 + 1)
        elseif roll2 == 2 then
            aug2 = xi.augment.ACCURACY_P1
            val2 = math.random(1, 3) * math.random(1, 2)
            desc2 = "Accuracy+" .. (val2 + 1)
        else
            if math.random(1, 2) == 1 then
                aug2 = xi.augment.RESIST_BLIND_P1
                val2 = 3 * math.random(1, 3)
                desc2 = "Resist Blind+" .. (val2 + 1)
            else
                aug2 = xi.augment.RESIST_PARALYZE_P1
                val2 = 3 * math.random(1, 3)
                desc2 = "Resist Paralyze+" .. (val2 + 1)
            end
        end
        
        player:tradeComplete()
        player:addItem(xi.item.ROSE_STRAP, 1, aug1, val1, aug2, val2)
        player:printToPlayer("You have successfully augmented your Rose Strap with " .. desc1 .. " and " .. desc2, xi.msg.channel.SYSTEM_3)
        player:printToPlayer("To examine the augment, highlight item and press minus key on numpad", xi.msg.channel.SYSTEM_3)
    
    -- Velocious Belt augments
    elseif npcUtil.tradeHasExactly(trade, {xi.item.VELOCIOUS_BELT, xi.item.V_EGG}) then
        local aug1 = math.random(xi.augment.STR_P1, xi.augment.CHR_P1)
        local val1 = math.random(0, 2)
        local aug2 = math.random(xi.augment.FIRE_RESIST_P1, xi.augment.DARK_RESIST_P1)
        local val2 = math.random(9, 29)

        -- Create descriptions
        local stats = {"STR", "DEX", "VIT", "AGI", "INT", "MND", "CHR"}
        local resists = {"Fire", "Ice", "Wind", "Earth", "Lightning", "Water", "Light", "Dark"}
        local desc1 = stats[aug1 - xi.augment.STR_P1 + 1] .. "+" .. (val1 + 1)
        local desc2 = resists[aug2 - xi.augment.FIRE_RESIST_P1 + 1] .. " Resist+" .. (val2 + 1)
        
        player:tradeComplete()
        player:addItem(xi.item.VELOCIOUS_BELT, 1, aug1, val1, aug2, val2)
        player:printToPlayer("You have successfully augmented your Velocious Belt with " .. desc1 .. " and " .. desc2, xi.msg.channel.SYSTEM_3)
        player:printToPlayer("To examine the augment, highlight item and press minus key on numpad", xi.msg.channel.SYSTEM_3)
    
    -- Loquacious Earring augments
    elseif npcUtil.tradeHasExactly(trade, {xi.item.LOQUACIOUS_EARRING, xi.item.V_EGG}) then
        local wheel4 = math.random(0, 3)
        local aug, val, desc
        
        if wheel4 == 0 then
            aug = xi.augment.MP_P1
            val = math.random(0, 20)
            desc = "MP+" .. (val + 1)
        elseif wheel4 == 1 then
            aug = xi.augment.CONSERVE_MP_P1
            val = math.random(4, 9)
            desc = "Conserve MP+" .. (val + 1)
        elseif wheel4 == 2 then
            aug = xi.augment.MAGIC_CRIT_DMG_P1
            val = math.random(0, 4)
            desc = "Magical Crit dmg+" .. (val + 1) .. "%"
        else
            aug = xi.augment.DARK_MAGIC_SKILL_P1
            val = math.random(2, 12)
            desc = "Dark Magic skill+" .. (val + 1)
        end
        
        player:tradeComplete()
        player:addItem(xi.item.LOQUACIOUS_EARRING, 1, aug, val)
        player:printToPlayer("You have successfully augmented your Loquacious Earring with " .. desc, xi.msg.channel.SYSTEM_3)
        player:printToPlayer("To examine the augment, highlight item and press minus key on numpad", xi.msg.channel.SYSTEM_3)
    
    -- Brutal Earring augments
    elseif npcUtil.tradeHasExactly(trade, {xi.item.BRUTAL_EARRING, xi.item.V_EGG}) then
        local aug1, val1, aug2, val2
        local desc1, desc2 = "", ""
        
        local roll1 = math.random(0, 3)
        if roll1 == 0 then
            aug1 = xi.augment.DOUBLE_ATTACK_P1
            val1 = math.random(0, 2)
            desc1 = "Double Attack+" .. (val1 + 1) .. "%"
        elseif roll1 == 1 then
            aug1 = xi.augment.DUAL_WIELD_P1
            val1 = math.random(0, 2)
            desc1 = "Dual Wield+" .. (val1 + 1)
        elseif roll1 == 2 then
            aug1 = xi.augment.HASTE_P1
            val1 = 0
            desc1 = "Haste+1%"
        else
            aug1 = xi.augment.SLOW_P1
            val1 = 0
            desc1 = "Slow+1"
        end
        
        local roll2 = math.random(0, 3)
        if roll2 == 0 then
            aug2 = xi.augment.DOUBLE_ATTACK_P1
            val2 = math.random(0, 2)
            desc2 = "Double Attack+" .. (val2 + 1) .. "%"
        elseif roll2 == 1 then
            aug2 = xi.augment.DUAL_WIELD_P1
            val2 = math.random(0, 2)
            desc2 = "Dual Wield+" .. (val2 + 1)
        elseif roll2 == 2 then
            aug2 = xi.augment.HASTE_P1
            val2 = 0
            desc2 = "Haste+1%"
        else
            aug2 = xi.augment.SLOW_P1
            val2 = 0
            desc2 = "Slow+1"
        end
        
        player:tradeComplete()
        player:addItem(xi.item.BRUTAL_EARRING, 1, aug1, val1, aug2, val2)
        player:printToPlayer("You have successfully augmented your Brutal Earring with " .. desc1 .. " and " .. desc2, xi.msg.channel.SYSTEM_3)
        player:printToPlayer("To examine the augment, highlight item and press minus key on numpad", xi.msg.channel.SYSTEM_3)
    
    -- Prism Cape augments
    elseif npcUtil.tradeHasExactly(trade, {xi.item.PRISM_CAPE, {xi.item.G_EGG, 3}}) then
        local wheel4 = math.random(0, 3)
        local aug, val, desc
        
        if wheel4 == 0 then
            aug = xi.augment.MAGIC_CRIT_HIT_RATE_P1
            val = math.random(0, 3)
            desc = "Magic crit rate+" .. (val + 1)
        elseif wheel4 == 1 then
            aug = xi.augment.MAG_ACC_P1
            val = math.random(0, 3)
            desc = "Magic accuracy+" .. (val + 1)
        elseif wheel4 == 2 then
            aug = xi.augment.CURE_POTENCY_P1
            val = math.random(0, 3)
            desc = "Cure potency+" .. (val + 1) .. "%"
        else
            aug = xi.augment.SPELL_INTERRUPTION_RATE_DOWN_P1
            val = math.random(9, 19)
            desc = "Spell interruption rate-" .. (val + 1) .. "%"
        end
        
        player:tradeComplete()
        player:addItem(xi.item.PRISM_CAPE, 1, aug, val)
        player:printToPlayer("You have successfully augmented your Prism Cape with " .. desc, xi.msg.channel.SYSTEM_3)
        player:printToPlayer("To examine the augment, highlight item and press minus key on numpad", xi.msg.channel.SYSTEM_3)
    
    -- Walahra Turban augments
    elseif npcUtil.tradeHasExactly(trade, {xi.item.WALAHRA_TURBAN, xi.item.J_EGG}) then
        local wheel4 = math.random(0, 3)
        local aug, val, desc
        
        if wheel4 == 0 then
            aug = xi.augment.STORE_TP_P1
            val = math.random(2, 9)
            desc = "Store TP+" .. (val + 1)
        elseif wheel4 == 1 then
            aug = xi.augment.HASTE_P1
            val = 0
            desc = "Haste+1%"
        elseif wheel4 == 2 then
            aug = xi.augment.EVASION_P1
            val = math.random(7, 9)
            desc = "Evasion+" .. (val + 1)
        else
            aug = xi.augment.ENHANCING_MAGIC_SKILL_P1
            val = math.random(2, 9)
            desc = "Enhancing Magic+" .. (val + 1)
        end
        
        player:tradeComplete()
        player:addItem(xi.item.WALAHRA_TURBAN, 1, aug, val)
        player:printToPlayer("You have successfully augmented your Wal-Mart Turban with " .. desc, xi.msg.channel.SYSTEM_3)
        player:printToPlayer("To examine the augment, highlight item and press minus key on numpad", xi.msg.channel.SYSTEM_3)
    
    -- Haubergeon +1 augments
    elseif npcUtil.tradeHasExactly(trade, {xi.item.HAUBERGEON_P1, xi.item.V_EGG}) then
        local skills = {
            {id = xi.augment.SWORD_SKILL_P1, name = "Sword"},
            {id = xi.augment.GREAT_SWORD_SKILL_P1, name = "Great Sword"},
            {id = xi.augment.AXE_SKILL_P1, name = "Axe"},
            {id = xi.augment.GREAT_AXE_SKILL_P1, name = "Great Axe"},
            {id = xi.augment.SCYTHE_SKILL_P1, name = "Scythe"},
            {id = xi.augment.POLEARM_SKILL_P1, name = "Polearm"},
            {id = xi.augment.KATANA_SKILL_P1, name = "Katana"},
            {id = xi.augment.GREAT_KATANA_SKILL_P1, name = "Great Katana"},
            {id = xi.augment.CLUB_SKILL_P1, name = "Club"}
        }
        
        local wheel9 = math.random(1, 9)
        local skill = skills[wheel9]
        local skillValue = math.random(2, 7)
        local defValue = math.random(0, 31)
        
        player:tradeComplete()
        player:addItem(xi.item.HAUBERGEON_P1, 1, skill.id, skillValue, xi.augment.DEF_P1, defValue)
        player:printToPlayer("You have successfully augmented your Hauby with " .. skill.name .. " Skill+" .. (skillValue + 1) .. " and DEF+" ..(defValue + 1), xi.msg.channel.SYSTEM_3)
        player:printToPlayer("To examine the augment, highlight item and press minus key on numpad", xi.msg.channel.SYSTEM_3)
    
    -- Bibiki Seashell augments
    elseif npcUtil.tradeHasExactly(trade, {xi.item.BIBIKI_SEASHELL, xi.item.V_EGG}) then
        local wheel4 = math.random(0, 3)
        local secondaryAug, secondaryVal, desc
        
        if wheel4 == 0 then
            secondaryAug = xi.augment.SPELL_INTERRUPTION_RATE_DOWN_P1
            secondaryVal = math.random(0, 2)
            desc = "Spell interruption rate-" .. (secondaryVal + 1) .. "%"
        elseif wheel4 == 1 then
            secondaryAug = xi.augment.PHYS_DMG_TAKEN_M1
            secondaryVal = math.random(0, 2)
            desc = "Phys dmg taken-" .. (secondaryVal + 1) .. "%"
        elseif wheel4 == 2 then
            secondaryAug = xi.augment.MAGIC_DMG_TAKEN_M1
            secondaryVal = math.random(0, 2)
            desc = "Magic dmg taken-" .. (secondaryVal + 1) .. "%"
        else
            secondaryAug = xi.augment.BREATH_DMG_TAKEN_M1
            secondaryVal = math.random(0, 2)
            desc = "Breath dmg taken-" .. (secondaryVal + 1) .. "%"
        end
        
        local healingHP = math.random(0, 4)
        local healingMP = math.random(0, 4)
        
        player:tradeComplete()
        player:addItem(xi.item.BIBIKI_SEASHELL, 1,
            xi.augment.HP_RECOVERED_WHILE_HEALING_P1, healingHP,
            xi.augment.MP_RECOVERED_WHILE_HEALING_P1, healingMP,
            secondaryAug, secondaryVal)
        player:printToPlayer("You have successfully augmented your Bibiki Seashell with HP+" .. (healingHP + 1) .. " & MP+" .. (healingMP + 1) .. " while healing and " .. desc, xi.msg.channel.SYSTEM_3)
        player:printToPlayer("To examine the augment, highlight item and press minus key on numpad", xi.msg.channel.SYSTEM_3)
    end
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        {xi.item.G_EGG,  166666},
        {xi.item.V_EGG,  500000},
        {xi.item.J_EGG,  500000},
        {xi.item.H_EGG,  250000},
        {xi.item.M_EGG,  350000},
        {xi.item.S_EGG,  1000000},
        {xi.item.D_EGG,  10000000},
    }

    player:printToPlayer("Trade Prism Cape and 3 G eggs for augments (Random chance for values)", xi.msg.channel.SAY, "Pil")
    player:printToPlayer("Trade Loquacious earring or Velocious Belt and V egg for augments (Random chance for values)", xi.msg.channel.SAY, "Pil")
    player:printToPlayer("Trade Walahra Turban or Rose Strap and J egg for augments (Random chance for values)", xi.msg.channel.SAY, "Pil")
    player:printToPlayer("To remove an augment, trade me the item and 50,000 gil.", xi.msg.channel.SAY, "Pil")

    xi.shop.general(player, stock)
end

return entity
