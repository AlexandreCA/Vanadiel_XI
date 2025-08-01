-----------------------------------
-- Hunger Strikes
-----------------------------------
-- !addquest 9 76
-- Westerly Breeze : !pos 62 32 123 256
-----------------------------------

local quest = Quest:new(xi.questLog.ADOULIN, xi.quest.id.adoulin.HUNGER_STRIKES)

quest.reward =
{
    fameArea = xi.fameArea.ADOULIN,
    bayld    = 500,
    exp      = 1000,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Westerly_Breeze'] = quest:progressEvent(2530),

            onEventFinish =
            {
                [2530] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        ['Westerly_Breeze'] =
        {
            onTrade = function(player, npc, trade)
                if npcUtil.tradeHasExactly(trade, xi.item.BOWL_OF_WISDOM_SOUP) then
                    return quest:progressEvent(2532)
                elseif
                    trade:getItemCount() == 1 and
                    trade:getGil() == 0
                then
                    local itemObj = trade:getItem(0)
                    local auctionCategory = itemObj:getAHCat()

                    if
                        auctionCategory >= xi.itemAHCategory.MEAT_EGGS and
                        auctionCategory <= xi.itemAHCategory.SWEETS
                    then
                        return quest:event(2533)
                    end
                end
            end,

            onTrigger = quest:event(2531),
        },

        onEventFinish =
        {
            [2532] = function(player, csid, option, npc)
                if quest:complete(player) then
                    player:confirmTrade()

                    xi.quest.setVar(player, xi.questLog.ADOULIN, xi.quest.id.adoulin.THE_STARVING, 'Timer', VanadielUniqueDay() + 1)
                end
            end,

            [2533] = function(player, csid, option, npc)
                player:confirmTrade()
            end,
        },
    },
}

return quest
