class GildedRose

  def initialize(items)
    @items = items
  end

  def expand_quality(item)
    item.quality += 1 unless item.quality >= 50 #Quality of item never more than 50
  end

  def decrease_quality(item, default=1)
    item.quality -= default if item.quality > 0 #Quality of item never negative
  end

  def backstage_passes(item)
    expand_quality(item)
    # Quality increases by 2 when there are 10 days or less
    expand_quality(item) if item.sell_in < 11
    # Quality increases by 3 when there are 5 days or less
    expand_quality(item) if item.sell_in < 6
  end

  def update_quality()
    @items.each do |item|
      case item.name
      when 'Aged Brie'
        expand_quality(item) # "Aged Brie" actually increases in Quality the older it gets
      when 'Conjured Mana Cake'
        decrease_quality(item, 2)
      when 'Backstage passes to a TAFKAL80ETC concert'
        backstage_passes(item) #Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less.
      when 'Sulfuras, Hand of Ragnaros'
        #"Sulfuras", being a legendary item, never has to be sold or decreases in Quality
      else
        decrease_quality(item)
      end
      sell_in_quality_conditions(item)
      item.sell_in -= 1 unless item.name == "Sulfuras, Hand of Ragnaros"
    end
  end

  def sell_in_quality_conditions(item)
    if item.sell_in < 0
      if item.name != "Aged Brie"
        if item.name != "Backstage passes to a TAFKAL80ETC concert"
          decrease_quality(item) if item.name != "Sulfuras, Hand of Ragnaros"
        else
          item.quality = item.quality - item.quality
        end
      else
        expand_quality(item)
      end
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end