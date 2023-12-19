require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    describe "Decreases sell-in and Quality" do
      it "decreases the sell in and quality for Normal items by 1)" do
        items = [Item.new("+5 Dexterity Vest", 10, 20)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "+5 Dexterity Vest, 9, 19"
      end
    end

    describe "Aged Brie" do
      it "increases the quality of 'Aged Brie'" do
        items = [Item.new("Aged Brie", 2, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "Aged Brie, 1, 1"
      end
    end

    describe "Sulfuras" do
      it "'Sulfuras' never has to be sold or decreases in Quality" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "Sulfuras, Hand of Ragnaros, 0, 80"
      end
    end

    describe "Backstage Passes" do
      it "'Backstage passes' varies with sell-in" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "Backstage passes to a TAFKAL80ETC concert, 14, 21"
      end

      it "'Backstage passes' increases by 2 when there are 10 days or less" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 48)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "Backstage passes to a TAFKAL80ETC concert, 9, 50"
      end

      it "'Backstage passes' increases by 3 when there are 5 days or less" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 47)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "Backstage passes to a TAFKAL80ETC concert, 4, 50"
      end
    end

    describe "Conjured Item" do
      it "'Conjured Mana Cake' decreases quality twice as fast" do
        items = [Item.new("Conjured Mana Cake", 2, 4)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "Conjured Mana Cake, 1, 2"
      end
    end

    describe "Quality never goes below 0" do
      it "ensures quality never goes below 0" do
        items = [Item.new("Elixir of the Mongoose", 3, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "Elixir of the Mongoose, 2, 0"
      end
    end
  end

end
