require_relative '../../lib/stackdo'

describe Stackdo::CallStack do
  let(:call_stack) do
    Stackdo::CallStack.new(
      frames: [
        Stackdo::Frame.new(
          location: Stackdo::Location.new("bob.rs", 32),
          environment: Stackdo::Environment.new(
            variables: [
              Stackdo::Variable.new("str", "hello world")
            ]
          ),
        ),
      ]
    )
  end

  it "has 1 frame" do
    expect(call_stack.frames.size).to eq 1
  end
end
