-------------------------------------------
-- Magian trial functions, vars, tables
-------------------------------------------

-----------------------------------
-- getTrialInfo
-----------------------------------
-- once fully filled out, these info tables might get large enough to need their own file, we'll see...
function getTrialInfo(ItemID)
    local TrialInfo = {}
    if (ItemID == 19327) then -- Pugilists
        TrialInfo.t1 = 68
        TrialInfo.t2 = 82
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    elseif (ItemID == 19332) then -- Peeler
        TrialInfo.t1 = 2
        TrialInfo.t2 = 16
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    elseif (ItemID == 19337) then -- Side-sword
        TrialInfo.t1 = 150
        TrialInfo.t2 = 164
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    elseif (ItemID == 19342) then -- Break Blade
        TrialInfo.t1 = 216
        TrialInfo.t2 = 230
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    elseif (ItemID == 19347) then -- Chopper
        TrialInfo.t1 = 282
        TrialInfo.t2 = 296
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    elseif (ItemID == 19352) then -- Lumberjack
        TrialInfo.t1 = 364
        TrialInfo.t2 = 378
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    elseif (ItemID == 19357) then -- Farmhand
        TrialInfo.t1 = 512
        TrialInfo.t2 = 526
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    elseif (ItemID == 19362) then -- Ranseur
        TrialInfo.t1 = 430
        TrialInfo.t2 = 444
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    elseif (ItemID == 19367) then -- KibaShiri
        TrialInfo.t1 = 578
        TrialInfo.t2 = 592
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    elseif (ItemID == 19372) then -- Donto
        TrialInfo.t1 = 644
        TrialInfo.t2 = 658
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    elseif (ItemID == 19377) then -- Stenz
        TrialInfo.t1 = 710
        TrialInfo.t2 = 724
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    elseif (ItemID == 19382) then -- Crook
        TrialInfo.t1 = 776
        TrialInfo.t2 = 790
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    elseif (ItemID == 19387) then -- Sparrow
        TrialInfo.t1 = 0
        TrialInfo.t2 = 0
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    elseif (ItemID == 19392) then -- Thunderstick
        TrialInfo.t1 = 941
        TrialInfo.t2 = 891
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    -- elsif
    --
    else -- Not a valid Item, return zeros for all.
        TrialInfo.t1 = 0
        TrialInfo.t2 = 0
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    end
end


-----------------------------------
-- getEmoteTrialInfo
-----------------------------------

function getEmoteTrialInfo(ItemID)
    local TrialInfo = {}
    if (ItemID == 11988) then -- Fighter's Torque
        TrialInfo.t1 = 4424
        TrialInfo.t2 = 0
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    elseif (ItemID == 11989) then -- Temple Torque
        TrialInfo.t1 = 4425
        TrialInfo.t2 = 0
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    elseif (ItemID == 11990) then -- Healer's Torque
        TrialInfo.t1 = 4426
        TrialInfo.t2 = 0
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    elseif (ItemID == 11991) then -- Wizard's Torque
        TrialInfo.t1 = 4427
        TrialInfo.t2 = 0
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    elseif (ItemID == 11992) then -- Warlock's Torque
        TrialInfo.t1 = 4428
        TrialInfo.t2 = 0
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    elseif (ItemID == 11993) then -- Rogue's Torque
        TrialInfo.t1 = 4429
        TrialInfo.t2 = 0
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    elseif (ItemID == 11994) then -- Gallant Torque
        TrialInfo.t1 = 4430
        TrialInfo.t2 = 0
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    elseif (ItemID == 11995) then -- Chaos Torque
        TrialInfo.t1 = 4431
        TrialInfo.t2 = 0
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    elseif (ItemID == 11996) then -- Beast Torque
        TrialInfo.t1 = 4432
        TrialInfo.t2 = 0
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    elseif (ItemID == 11997) then -- Choral Torque
        TrialInfo.t1 = 4433
        TrialInfo.t2 = 0
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    elseif (ItemID == 11998) then -- Hunter's Torque
        TrialInfo.t1 = 4434
        TrialInfo.t2 = 0
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    elseif (ItemID == 11999) then -- Myochin Shusa
        TrialInfo.t1 = 4435
        TrialInfo.t2 = 0
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    elseif (ItemID == 12000) then -- Ninja Shusa
        TrialInfo.t1 = 4436
        TrialInfo.t2 = 0
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    elseif (ItemID == 12001) then -- Drachen Torque
        TrialInfo.t1 = 4437
        TrialInfo.t2 = 0
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    elseif (ItemID == 12002) then -- Evoker's Torque
        TrialInfo.t1 = 4438
        TrialInfo.t2 = 0
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    elseif (ItemID == 12003) then -- Magus Torque
        TrialInfo.t1 = 4439
        TrialInfo.t2 = 0
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    elseif (ItemID == 12004) then -- Corsair's Torque
        TrialInfo.t1 = 4440
        TrialInfo.t2 = 0
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    elseif (ItemID == 12005) then -- Puppetry Torque
        TrialInfo.t1 = 4441
        TrialInfo.t2 = 0
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    elseif (ItemID == 12006) then -- Dancer's Torque
        TrialInfo.t1 = 4442
        TrialInfo.t2 = 0
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    elseif (ItemID == 12007) then -- Scholar's Torque
        TrialInfo.t1 = 4443
        TrialInfo.t2 = 0
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    else -- Not a valid Item, return zeros for all.
        TrialInfo.t1 = 0
        TrialInfo.t2 = 0
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    end
end


-----------------------------------
-- getRelicTrialInfo
-----------------------------------

function getRelicTrialInfo(ItemID)
    local TrialInfo = {}
    if (ItemID == 19327) then --
        TrialInfo.t1 = 0
        TrialInfo.t2 = 0
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    else -- Not a valid Item, return zeros for all.
        TrialInfo.t1 = 0
        TrialInfo.t2 = 0
        TrialInfo.t3 = 0
        TrialInfo.t4 = 0
        return TrialInfo
    end
end

-----------------------------------
-- magianOrangeEventUpdate
-----------------------------------

function magianOrangeEventUpdate(player, ItemID, csid, option)
    -- DO NOT try to convert into "elseif" !
    -- Probably need to table all this too, for now I'm just mapping it out.
    if (csid == 10124 and option == 4456449) then
        local ReqItemAugFlag = 2 -- 2 = ON, anything else = OFF.
        local ReqItemAug1 = 1
        local ReqItemAug2 = 1
        local ReqItem = 19332
        local TrialID = 9
        player:updateEvent(ReqItemAugFlag, ReqItemAug1, ReqItemAug2, ReqItem, 0, 0, TrialID)
    end
    if (csid == 10124 and option == 4456450) then
        local TotalObjectives = 11
        player:updateEvent(TotalObjectives)
    end
    if (csid == 10124 and option == 4456451) then
        local RewardAugFlag = 2 -- 2 = ON, anything else = OFF.
        local RewardAug1 = 1
        local RewardAug2 = 1
        local RewardItem = 19328
        player:updateEvent(RewardAugFlag, RewardAug1, RewardAug2, RewardItem)
    end
    if (csid == 10124 and option == 4456452) then
        local ResultTrial1 = 69
        local ResultTrial2 = 0
        local ResultTrial3 = 0
        local ResultTrial4 = 0
        local PrevTrial = 0
        player:updateEvent(ResultTrial1, ResultTrial2, ResultTrial3, ResultTrial4, PrevTrial)
    end
end

-----------------------------------
-- magianGreenEventUpdate
-----------------------------------

function magianGreenEventUpdate(player, ItemID, csid, option)
end

-----------------------------------
-- magianBlueEventUpdate
-----------------------------------

function magianBlueEventUpdate(player, ItemID, csid, option)
end
