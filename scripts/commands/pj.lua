-----------------------------------
-- func: pj <party member> (forceZone)
-- desc: 指定したパーティメンバーの位置へテレポ（同一パーティのみ）
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    -- 一般プレイヤーも使用できるようにする（同一パーティ内チェックで悪用を抑止）
    permission = 0,
    parameters = 'si'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!pj <パーティメンバー名> (forceZone)')
end

local function normalizeName(name)
    return string.lower(name or '')
end

commandObj.onTrigger = function(player, targetName, forceZone)
    if not targetName or targetName == '' then
        error(player, 'パーティメンバー名を入力してください。')
        return
    end

    if forceZone then
        if forceZone ~= 0 and forceZone ~= 1 then
            error(player, 'forceZone は 1(有効) または 0(無効) を指定してください。')
            return
        end
    else
        forceZone = 1
    end

    local party = player:getParty()
    if not party or #party <= 1 then
        error(player, 'パーティに参加していません。')
        return
    end

    local want = normalizeName(targetName)
    local targ = nil

    for _, member in ipairs(party) do
        if member and member:isPC() and normalizeName(member:getName()) == want then
            targ = member
            break
        end
    end

    if not targ then
        error(player, string.format('パーティ内に「%s」が見つかりません。', targetName))
        return
    end

    -- If they're in mog house, goto them instead of setPos (matches !goto behavior).
    if not targ:inMogHouse() then
        player:setPos(
            targ:getXPos(),
            targ:getYPos(),
            targ:getZPos(),
            targ:getRotPos(),
            forceZone == 1 and targ:getZoneID() or nil
        )
    elseif not player:gotoPlayer(targ:getName()) then
        error(player, string.format('「%s」へ移動できませんでした。', targ:getName()))
    end
end

return commandObj
