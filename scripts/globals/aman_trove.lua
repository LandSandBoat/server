-----------------------------------
-- A.M.A.N. Trove
-----------------------------------
xi.amanTrove = {}

xi.amanTrove.chestOPlentyOnTrigger = function(player, npc)
    if npc:getLocalVar('Mimic') == 1 then
        xi.amanTrove.prepareMimic(player, npc)
        return
    end

    print("You have triggered the Chest O'Plenty.")

    -- TODO: Thuds etc.
end

xi.amanTrove.terminalCofferOnTrigger = function(player, npc)
    print("You have triggered the Terminal Coffer.")

    -- TODO: Count up thuds, etc. generate loot
end

xi.amanTrove.prepareMimic = function(player, npc)
    print("The chest is a mimic!")

    -- TODO: Make all other chests disappear, change model into animated mimic, set enmity, etc.
end
