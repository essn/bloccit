describe Vote do
  describe "validations" do
    describe "value validation" do
      it "only allows -1 or 1 as values" do
        v = Vote.new(value: 1)
        v.valid? == true

        v = Vote.new(value: -1)
        v.valid? == true

        v = Vote.new(value: 2)
        v.valid? == false
      end
    end
  end
end