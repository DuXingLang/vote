package valuebean;

public class TempSingle {
	private String id;
	private String voteIp;
	private long voteMSEL;
	private String voteTime;
	
	public long getVoteMSEL() {
		return voteMSEL;
	}
	public void setVoteMSEL(long voteMSEL) {
		this.voteMSEL = voteMSEL;
	}
	public String getVoteTime() {
		return voteTime;
	}
	public void setVoteTime(String voteTime) {
		this.voteTime = voteTime;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getVoteIp() {
		return voteIp;
	}
	public void setVoteIp(String voteIp) {
		this.voteIp = voteIp;
	}
}
