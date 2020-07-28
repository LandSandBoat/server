require("scripts/globals/status")

utils = {}

-- Shuffles a table and returns a copy of it, not the original.
function utils.shuffle(tab)
    local copy = {}
    for k, v in pairs(tab) do
        copy[k] = v
    end

    local res = {}
    while next(copy) do
        res[#res + 1] = table.remove(copy, math.random(#copy))
    end
    return res
end

function utils.clamp(input, min_val, max_val)
    if input < min_val then
        input = min_val
    elseif max_val ~= nil and input > max_val then
        input = max_val
    end
    return input
end

-- returns unabsorbed damage
function utils.stoneskin(target, dmg)
    --handling stoneskin
    if (dmg > 0) then
        skin = target:getMod(tpz.mod.STONESKIN)
        if (skin > 0) then
            if (skin > dmg) then --absorb all damage
                target:delMod(tpz.mod.STONESKIN, dmg)
                return 0
            else --absorbs some damage then wear
                target:delStatusEffect(tpz.effect.STONESKIN)
                target:setMod(tpz.mod.STONESKIN, 0)
                return dmg - skin
            end
        end
    end

    return dmg
end

function utils.takeShadows(target, dmg, shadowbehav)
    if (shadowbehav == nil) then
        shadowbehav = 1
    end

    local targShadows = target:getMod(tpz.mod.UTSUSEMI)
    local shadowType = tpz.mod.UTSUSEMI

    if (targShadows == 0) then --try blink, as utsusemi always overwrites blink this is okay
        targShadows = target:getMod(tpz.mod.BLINK)
        shadowType = tpz.mod.BLINK
    end

    if (targShadows > 0) then
    --Blink has a VERY high chance of blocking tp moves, so im assuming its 100% because its easier!

        if (targShadows >= shadowbehav) then --no damage, just suck the shadows

            local shadowsLeft = targShadows - shadowbehav

            target:setMod(shadowType, shadowsLeft)

            if (shadowsLeft > 0 and shadowType == tpz.mod.UTSUSEMI) then --update icon
                effect = target:getStatusEffect(tpz.effect.COPY_IMAGE)
                if (effect ~= nil) then
                    if (shadowsLeft == 1) then
                        effect:setIcon(tpz.effect.COPY_IMAGE)
                    elseif (shadowsLeft == 2) then
                        effect:setIcon(tpz.effect.COPY_IMAGE_2)
                    elseif (shadowsLeft == 3) then
                        effect:setIcon(tpz.effect.COPY_IMAGE_3)
                    end
                end
            end
            -- remove icon
            if (shadowsLeft <= 0) then
                target:delStatusEffect(tpz.effect.COPY_IMAGE)
                target:delStatusEffect(tpz.effect.BLINK)
            end

            return 0
        else --less shadows than this move will take, remove all and factor damage down
            target:delStatusEffect(tpz.effect.COPY_IMAGE)
            target:delStatusEffect(tpz.effect.BLINK)
            return dmg * ((shadowbehav-targShadows)/shadowbehav)
        end
    end

    return dmg
end

-- returns true if taken by third eye
function utils.thirdeye(target)
    --third eye doesnt care how many shadows, so attempt to anticipate, but reduce
    --chance of anticipate based on previous successful anticipates.
    local teye = target:getStatusEffect(tpz.effect.THIRD_EYE)

    if (teye == nil) then
        return false
    end

    local prevAnt = teye:getPower()

    if ( prevAnt == 0 or (math.random()*100) < (80-(prevAnt*10)) ) then
        --anticipated!
        target:delStatusEffect(tpz.effect.THIRD_EYE)
        return true
    end

    return false
end

-----------------------------------
--     SKILL LEVEL CALCULATOR
--     Returns a skill level based on level and rating.
--
--    See the translation of aushacho's work by Themanii:
--    http://home.comcast.net/~themanii/skill.html
--
--    The arguments are skill rank (numerical), and level.  1 is A+, 2 is A-, and so on.
-----------------------------------

function utils.getSkillLvl(rank, level)

    local skill = 0 --Failsafe

    if (level <= 50) then --Levels 1-50
        if (rank == 1 or rank == 2) then --A-Rated Skill
            skill = (((level-1)*3)+6)
        elseif (rank == 3 or rank == 4 or rank == 5) then --B-Rated Skill
            skill = (((level-1)*2.9)+5)
        elseif (rank == 6 or rank == 7 or rank == 8) then --C-Rated Skill
            skill = (((level-1)*2.8)+5)
        elseif (rank == 9) then --D-Rated Skill
            skill = (((level-1)*2.7)+4)
        elseif (rank == 10) then --E-Rated Skill
            skill = (((level-1)*2.5)+4)
        elseif (rank == 11) then --F-Rated Skill
            skill = (((level-1)*2.3)+4)
        end
    elseif (level > 50 and level <= 60) then --Levels 51-60
        if (rank == 1 or rank == 2) then --A-Rated Skill
            skill = (((level-50)*5)+153)
        elseif (rank == 3 or rank == 4 or rank == 5) then --B-Rated Skill
            skill = (((level-50)*4.9)+147)
        elseif (rank == 6 or rank == 7 or rank == 8) then --C-Rated Skill
            skill = (((level-50)*4.8)+142)
        elseif (rank == 9) then --D-Rated Skill
            skill = (((level-50)*4.7)+136)
        elseif (rank == 10) then --E-Rated Skill
            skill = (((level-50)*4.5)+126)
        elseif (rank == 11) then --F-Rated Skill
            skill = (((level-50)*4.3)+116)
        end
    elseif (level > 60 and level <= 70) then --Levels 61-70
        if (rank == 1) then --A+ Rated Skill
            skill = (((level-60)*4.85)+203)
        elseif (rank == 2) then --A- Rated Skill
            skill = (((level-60)*4.10)+203)
        elseif (rank == 3) then --B+ Rated Skill
            skill = (((level-60)*3.70)+196)
        elseif (rank == 4) then --B Rated Skill
            skill = (((level-60)*3.23)+196)
        elseif (rank == 5) then --B- Rated Skill
            skill = (((level-60)*2.70)+196)
        elseif (rank == 6) then --C+ Rated Skill
            skill = (((level-60)*2.50)+190)
        elseif (rank == 7) then --C Rated Skill
            skill = (((level-60)*2.25)+190)
        elseif (rank == 8) then --C- Rated Skill
            skill = (((level-60)*2.00)+190)
        elseif (rank == 9) then --D Rated Skill
            skill = (((level-60)*1.85)+183)
        elseif (rank == 10) then --E Rated Skill
            skill = (((level-60)*1.95)+171)
        elseif (rank == 11) then --F Rated Skill
            skill = (((level-60)*2.05)+159)
        end
    else --Level 71 and above
        if (rank == 1) then --A+ Rated Skill
            skill = (((level-70)*5)+251)
        elseif (rank == 2) then --A- Rated Skill
            skill = (((level-70)*5)+244)
        elseif (rank == 3) then --B+ Rated Skill
            skill = (((level-70)*3.70)+233)
        elseif (rank == 4) then --B Rated Skill
            skill = (((level-70)*3.23)+228)
        elseif (rank == 5) then --B- Rated Skill
            skill = (((level-70)*2.70)+223)
        elseif (rank == 6) then --C+ Rated Skill
            skill = (((level-70)*3)+215)
        elseif (rank == 7) then --C Rated Skill
            skill = (((level-70)*2.6)+212)
        elseif (rank == 8) then --C- Rated Skill
            skill = (((level-70)*2.00)+210)
        elseif (rank == 9) then --D Rated Skill
            skill = (((level-70)*1.85)+201)
        elseif (rank == 10) then --E Rated Skill
            skill = (((level-70)*1.95)+190)
        elseif (rank == 11) then --F Rated Skill
            skill = (((level-70)*2)+179)
        end
    end

    return skill

end

function utils.getMobSkillLvl(rank, level)
     if(level > 50) then
         if(rank == 1) then
             return 153+(level-50)*5.0
         end
         if(rank == 2) then
             return 147+(level-50)*4.9
         end
         if(rank == 3) then
             return 136+(level-50)*4.8
         end
         if(rank == 4) then
             return 126+(level-50)*4.7
         end
         if(rank == 5) then
             return 116+(level-50)*4.5
         end
         if(rank == 6) then
             return 106+(level-50)*4.4
         end
         if(rank == 7) then
             return 96+(level-50)*4.3
         end
     end

     if(rank == 1) then
         return 6+(level-1)*3.0
     end
     if(rank == 2) then
         return 5+(level-1)*2.9
     end
     if(rank == 3) then
         return 5+(level-1)*2.8
     end
     if(rank == 4) then
         return 4+(level-1)*2.7
     end
     if(rank == 5) then
         return 4+(level-1)*2.5
     end
     if(rank == 6) then
         return 3+(level-1)*2.4
     end
     if(rank == 7) then
         return 3+(level-1)*2.3
     end
    return 0
end

-- Returns 1 if attacker has a bonus
-- Returns 0 no bonus
-- Returns -1 if weak against
function utils.getSystemStrengthBonus(attacker, defender)
    local attackerSystem = attacker:getSystem()
    local defenderSystem = defender:getSystem()

    if (attackerSystem == tpz.eco.BEAST) then
        if (defenderSystem == tpz.eco.LIZARD) then
            return 1
        elseif (defenderSystem == tpz.eco.PLANTOID) then
            return -1
        end
    end

    if (attackerSystem == tpz.eco.LIZARD) then
        if (defenderSystem == tpz.eco.VERMIN) then
            return 1
        elseif (defenderSystem == tpz.eco.BEAST) then
            return -1
        end
    end

    if (attackerSystem == tpz.eco.VERMIN) then
        if (defenderSystem == tpz.eco.PLANTOID) then
            return 1
        elseif (defenderSystem == tpz.eco.LIZARD) then
            return -1
        end
    end

    if (attackerSystem == tpz.eco.PLANTOID) then
        if (defenderSystem == tpz.eco.BEAST) then
            return 1
        elseif (defenderSystem == tpz.eco.VERMIN) then
            return -1
        end
    end

    if (attackerSystem == tpz.eco.AQUAN) then
        if (defenderSystem == tpz.eco.AMORPH) then
            return 1
        elseif (defenderSystem == tpz.eco.BIRD) then
            return -1
        end
    end

    if (attackerSystem == tpz.eco.AMORPH) then
        if (defenderSystem == tpz.eco.BIRD) then
            return 1
        elseif (defenderSystem == tpz.eco.AQUAN) then
            return -1
        end
    end

    if (attackerSystem == tpz.eco.BIRD) then
        if (defenderSystem == tpz.eco.AQUAN) then
            return 1
        elseif (defenderSystem == tpz.eco.AMORPH) then
            return -1
        end
    end

    if (attackerSystem == tpz.eco.UNDEAD) then
        if (defenderSystem == tpz.eco.ARCANA) then
            return 1
        end
    end

    if (attackerSystem == tpz.eco.ARCANA) then
        if (defenderSystem == tpz.eco.UNDEAD) then
            return 1
        end
    end

    if (attackerSystem == tpz.eco.DRAGON) then
        if (defenderSystem == tpz.eco.DEMON) then
            return 1
        end
    end

    if (attackerSystem == tpz.eco.DEMON) then
        if (defenderSystem == tpz.eco.DRAGON) then
            return 1
        end
    end

    if (attackerSystem == tpz.eco.LUMORIAN) then
        if (defenderSystem == tpz.eco.LUMINION) then
            return 1
        end
    end

    if (attackerSystem == tpz.eco.LUMINION) then
        if (defenderSystem == tpz.eco.LUMORIAN) then
            return 1
        end
    end

    return 0
end

-------------------------------------------------------
-- Returns true if player has any tier of given relic,
--  if tier is specified, returns true only if player
--  has that tier
-- Tier:
-- 1  = 75
-- 2  = 80
-- 3  = 85
-- 4  = 90
-- 5  = 95
-- 6  = 99 I
-- 7  = 99 II
-- 8  = 119 I
-- 9  = 119 II
-- 10 = 119 III
-- 11 = 119 III (ammo dispensing)
-------------------------------------------------------
function utils.hasRelic(player, relic, tier)
    if tier ~= nil then
        return player:hasItem(tpz.relicTiers[relic][tier])
    end

    for i, itemID in pairs(tpz.relicTiers[relic]) do
        if player:hasItem(itemID) then
            return true
        end
    end

    return false
end
