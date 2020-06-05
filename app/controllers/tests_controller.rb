class TestsController < Simpler::Controller

  def index
    # @time = Time.now
    # render inline: "inlineeeeee\n"
    # render plain: "plainnnnn\n"
    # render 'tests/list'
    # status 777
    # headers['qwe'] = 'qwe'
    @tests = Test.all
  end

  def show
    @test = Test.find(id: params[:id])
    @params = params
  end

  def create
    render plain: "Plain text response\n"
    status(201)
    headers['Content-Type-ASD'] = 'asdasdasd'
  end

end
